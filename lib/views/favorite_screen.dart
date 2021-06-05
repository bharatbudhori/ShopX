import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/models/product.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favotites ❤️'),
      ),
      body: GetBuilder(
        init: Get.find<ProductController>(),
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.favoriteList.length,
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
                        controller.favoriteList[index].imageLink,
                      ),
                    ),
                  ),
                  title: Text(
                    controller.favoriteList[index].name,
                    softWrap: true,
                  ),
                  trailing: Container(
                    width: 100,
                    height: 50,
                    child: Row(
                      children: [
                        Text(
                          '\$${controller.favoriteList[index].price}',
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
                              controller.toogleFavorite(
                                  controller.favoriteList[index]);
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
