import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_x/models/cart.dart';
import 'package:get/get.dart';
import 'package:shop_x/models/orders.dart';
import '../views/login_screen.dart';
import 'orders_controller.dart';

final UserController userController = Get.put(UserController());
final OrderController orderController = Get.put(OrderController());
User currentUser = userController.currentUser;

class CartController extends GetxController {
  var cartCollection = FirebaseFirestore.instance.collection('Cart');
  var adddedToCart = true;
  var totalPrice = 0.00.obs;
  List<CartItem> cartProductList = List<CartItem>.empty(growable: true).obs;
  //var cartProductList = List<CartItem>().obs;

  @override
  void onInit() async {
    print('Cart Controller init called');
    //addDummyData();
    //print(double.parse('56.008'));
    cartProductList.clear();
    fetchCartItems().then((_) {
      fetchTotal();
    });
    //fetchTotal();
    super.onInit();
  }

  // void addDummyData() {
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  // }

  void addProductsToCart(
    int id,
    String name,
    int quantity,
    String imageURL,
    String price,
  ) {
    totalPrice += double.parse(price);
    cartProductList.add(
      CartItem(
          id: id,
          name: name,
          quantity: quantity,
          price: price,
          imageUrl: imageURL),
    );
    cartCollection
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart')
        .doc(id.toString())
        .set({
      'ProductName': name,
      'ProductID': id,
      'Quantity': quantity,
      'Price': price,
      'ImageUrl': imageURL,
    });
    update();
  }

  Future<void> fetchCartItems() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart')
        .get();

    snapshot.docs.forEach((element) {
      cartProductList.add(CartItem(
        id: element['ProductID'],
        name: element['ProductName'],
        price: element['Price'],
        imageUrl: element['ImageUrl'],
        quantity: element['Quantity'],
      ));
    });
    update();
  }

  void clearCart() {
    cartProductList.clear();
    update();
  }

  void deletion(int id, String price) {
    cartProductList.removeWhere((element) => element.id == id);
    //cartProductList.removeAt(index);
    totalPrice -= double.parse(price);
    // cartCollection
    //     .doc(currentUser.uid)
    //     .collection('${currentUser.displayName} cart')
    //     .doc(id.toString())
    //     .delete();

    //cartCollection.doc()
    update();
  }

  void addToOrders({
    //int id,
    //String name,
    //int quantity,
    //String imageUrl,
    String price,
    DateTime dateTime,
    List<CartItem> orderListItem,
  }) {
    orderController.orderList.insert(
        0,
        Orders(
          //id: id,
          // name: name,
          // quantity: quantity,
          price: price,
          // imageUrl: imageUrl,
          dateTime: dateTime,
          orderListItem: orderListItem,
        ));
  }

  void fetchTotal() {
    for (var i = 0; i < cartProductList.length; i++) {
      totalPrice += double.parse(cartProductList[i].price);
    }
  }
}
