import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/controllers/orders_controller.dart';
import 'package:shop_x/controllers/product_controller.dart';

class UserScreen extends StatelessWidget {
  final User user;
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  UserScreen({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoURL),
              ),
            ),
          ),
          Text(
            user.displayName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 20,
            color: Colors.yellow,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Total Cart Items : ${cartController.cartProductList.length}',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 20,
            color: Colors.pink,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Total Favorites : ${productController.favProductList.length}',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 20,
            color: Colors.teal,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Total Orders : ${orderController.orderList.length}',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
