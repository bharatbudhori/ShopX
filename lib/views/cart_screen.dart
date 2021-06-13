import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/controllers/orders_controller.dart';
import 'package:shop_x/views/order_screen.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => OrderScreen());

              // for (int i = 0; i < cartController.cartProductList.length; i++) {
              //   orderController.placeOrders(
              //       cartController.cartProductList[i].id,
              //       cartController.cartProductList[i].name,
              //       cartController.cartProductList[i].quantity,
              //       cartController.cartProductList[i].price,
              //       cartController.cartProductList[i].imageUrl,
              //       DateTime.now());

              //   cartController.cartProductList
              //       .remove(cartController.cartProductList[i]);
              // }
            },
            child: Text('Order Now'),
          ),
        ],
      ),
      body: GetBuilder(
        init: cartController,
        builder: (controller) {
          return ListView.builder(
            itemCount: cartController.cartProductList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(controller.cartProductList[index].imageUrl),
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deletion(
                      index, controller.cartProductList[index].id);
                },
                child: Card(
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.network(
                          controller.cartProductList[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.cartProductList[index].name,
                            softWrap: true,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      Text(
                        '\$${controller.cartProductList[index].price}    ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.delete,
                      //     color: Colors.red,
                      //   ),
                      //   onPressed: () {
                      //     controller.deletion(index);
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
