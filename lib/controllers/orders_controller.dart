import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/models/orders.dart';
//import 'package:get/get.dart';

class OrderController extends GetxController {
  List<Orders> orderList = List<Orders>.empty(growable: true).obs;
  final CartController cartController = Get.put(CartController());
  //var orderList = List<Orders>().obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Order')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} orders')
        .get();

    snapshot.docs.forEach((element) {
      orderList.add(Orders(
        dateTime: element['dateTime'].toDate(),
        price: element['totalPrice'],
      ));
    });
    update();
  }

//   void placeOrders({
//     int id,
//     String name,
//     int quantity,
//     String price,
//     String imageUrl,
//     DateTime dateTime,
//   }) {
//     orderList.add(
//       Orders(
//         id: id,
//         name: name,
//         quantity: quantity,
//         price: price,
//         imageUrl: imageUrl,
//         dateTime: dateTime,
//         orderList: cartController.cartProductList,
//       ),
//     );
//     update();
//   }
}
