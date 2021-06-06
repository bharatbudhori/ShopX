import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        actions: [
          TextButton(
            onPressed: () {},
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
                  controller.deletion(index);
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
