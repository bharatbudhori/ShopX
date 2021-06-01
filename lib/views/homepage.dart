import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/views/product_tile.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ShopX',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.view_list_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.grid_view),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: productController.productList.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                //physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  if (productController.productList[index].rating != null) {
                    return ProductTile(productController.productList[index]);
                  } else {
                    return SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              );
            }),
          )
        ],
      ),
    );
  }
}
