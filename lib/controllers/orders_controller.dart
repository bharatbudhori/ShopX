import 'package:get/get.dart';
import 'package:shop_x/models/orders.dart';
//import 'package:get/get.dart';

class OrderController extends GetxController {
  List<Orders> orderList = List<Orders>.empty(growable: true).obs;
  //var orderList = List<Orders>().obs;

  void placeOrders(
    int id,
    String name,
    int quantity,
    String price,
    String imageUrl,
    DateTime dateTime,
  ) {
    orderList.add(
      Orders(
          id: id,
          name: name,
          quantity: quantity,
          price: price,
          imageUrl: imageUrl,
          dateTime: dateTime),
    );
    update();
  }
}
