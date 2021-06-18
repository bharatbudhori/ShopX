import 'package:cloud_firestore/cloud_firestore.dart';
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
    var cartCollection = FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart');
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: null,
        label: Obx(
          () => Text(
            'Total: \$${cartController.totalPrice}',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
      ),
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
      body: StreamBuilder(
          stream: cartCollection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data.docs.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                      'https://image.shutterstock.com/image-vector/shopping-basket-vector-icon-illustration-600w-678796057.jpg',
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No items added in your cart yet, add some !!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              );
            }

            // else if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Text("Loading");
            // }
            else {
              return ListView(
                children: snapshot.data.docs.map<Widget>((documnets) {
                  return Dismissible(
                    key: Key(documnets['ImageUrl']),
                    onDismissed: (direction) {
                      cartCollection
                          .doc(documnets['ProductID'].toString())
                          .delete();

                      //deleting from cartList
                      cartController.deletion(
                          documnets['ProductID'], documnets['Price']);
                    },
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
                    child: GestureDetector(
                      onTap: () {
                        //print(controller.favoriteList[index].name);
                      },
                      child: Card(
                        elevation: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Image.network(documnets['ImageUrl']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  documnets['ProductName'],
                                  softWrap: true,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            Text(
                              '\$${documnets['Price']}  ',
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
                            //     controller
                            //         .toogleFavorite(controller.favoriteList[index]);
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }),

      // GetBuilder(
      //   init: cartController,
      //   builder: (controller) {
      //     return ListView.builder(
      //       itemCount: cartController.cartProductList.length,
      //       itemBuilder: (context, index) {
      //         return Dismissible(
      //           key: Key(controller.cartProductList[index].imageUrl),
      //           background: Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Icon(
      //                   Icons.delete,
      //                   color: Colors.red,
      //                   size: 50,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           direction: DismissDirection.endToStart,
      //           onDismissed: (direction) {
      //             controller.deletion(
      //                 index, controller.cartProductList[index].id);
      //           },
      //           child: Card(
      //             elevation: 8,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Container(
      //                   padding: EdgeInsets.all(8),
      //                   height: 70,
      //                   width: 70,
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(30),
      //                   ),
      //                   child: Image.network(
      //                     controller.cartProductList[index].imageUrl,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Text(
      //                       controller.cartProductList[index].name,
      //                       softWrap: true,
      //                       style: TextStyle(fontSize: 17),
      //                     ),
      //                   ),
      //                 ),
      //                 Text(
      //                   '\$${controller.cartProductList[index].price}    ',
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //                 // IconButton(
      //                 //   icon: Icon(
      //                 //     Icons.delete,
      //                 //     color: Colors.red,
      //                 //   ),
      //                 //   onPressed: () {
      //                 //     controller.deletion(index);
      //                 //   },
      //                 // ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
