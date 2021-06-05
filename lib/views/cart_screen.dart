import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController =
      Get.put(CartController(), permanent: true);
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
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        cartController.cartProductList[index].imageUrl,
                      ),
                    ),
                  ),
                  title: Text(
                    cartController.cartProductList[index].name,
                    softWrap: true,
                  ),
                  trailing: Container(
                    width: 100,
                    height: 50,
                    child: Row(
                      children: [
                        Text(
                          '\$${cartController.cartProductList[index].price}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              controller.deletion(index);
                            }),
                      ],
                    ),
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
