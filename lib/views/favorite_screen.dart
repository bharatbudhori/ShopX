import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shop_x/controllers/product_controller.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteCollection = FirebaseFirestore.instance
        .collection('Favorites')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} Favorites');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favotites ❤️'),
      ),
      body: StreamBuilder(
          stream: favoriteCollection.snapshots(),
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
                      'https://st.depositphotos.com/1006899/3826/i/950/depositphotos_38266751-stock-photo-heart-balloons-on-purple-background.jpg',
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No Favorites added yet, add some !!',
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
                    key: Key(documnets['ImageURL']),
                    onDismissed: (direction) {
                      favoriteCollection
                          .doc(documnets['ProductID'].toString())
                          .delete();
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
                              child: Image.network(documnets['ImageURL']),
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

      //     GetBuilder(
      //   init: Get.find<ProductController>(),
      //   builder: (controller) {
      //     if (controller.favoriteList.isEmpty) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Image(
      //             image: NetworkImage(
      //               'https://st.depositphotos.com/1006899/3826/i/950/depositphotos_38266751-stock-photo-heart-balloons-on-purple-background.jpg',
      //             ),
      //           ),
      //           SizedBox(height: 60),
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text(
      //               'No Favorites added yet, add some !!',
      //               style: TextStyle(
      //                 fontSize: 25,
      //                 color: Colors.purple,
      //                 fontWeight: FontWeight.w700,
      //               ),
      //             ),
      //           )
      //         ],
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: controller.favoriteList.length,
      //       itemBuilder: (context, index) {
      //         return Dismissible(
      //           key: Key(controller.favoriteList[index].imageLink),
      //           onDismissed: (direction) {
      //             controller.toogleFavorite(controller.favoriteList[index]);
      //           },
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
      //           child: GestureDetector(
      //             onTap: () {
      //               print(controller.favoriteList[index].name);
      //             },
      //             child: Card(
      //               elevation: 8,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Container(
      //                     height: 80,
      //                     width: 80,
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(30),
      //                     ),
      //                     child: Image.network(
      //                         controller.favoriteList[index].imageLink),
      //                   ),
      //                   Expanded(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(
      //                         controller.favoriteList[index].name,
      //                         softWrap: true,
      //                         style: TextStyle(fontSize: 15),
      //                       ),
      //                     ),
      //                   ),
      //                   Text(
      //                     '\$${controller.favoriteList[index].price}  ',
      //                     style: TextStyle(
      //                       fontSize: 20,
      //                     ),
      //                   ),
      //                   // IconButton(
      //                   //   icon: Icon(
      //                   //     Icons.delete,
      //                   //     color: Colors.red,
      //                   //   ),
      //                   //   onPressed: () {
      //                   //     controller
      //                   //         .toogleFavorite(controller.favoriteList[index]);
      //                   //   },
      //                   // ),
      //                 ],
      //               ),
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
