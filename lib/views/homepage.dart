import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/views/cart_screen.dart';
//import 'package:shop_x/views/filter_content.dart';
import 'package:shop_x/views/product_tile.dart';

import 'favorite_screen.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  //final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ),
            onPressed: () {
              Get.to(() => FavoriteScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt_sharp),
            onPressed: () {
              Get.defaultDialog(
                title: 'Select Brand',
                //content: FilterContent(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              showBottomsheet();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.pinkAccent,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0DI22pl34SeQZ9RBxIfjNGyjaquYEIvuVow&usqp=CAU',
                    ),
                  ),
                  Text(
                    'Maximilian   🖊️',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () => Get.to(CartScreen()),
              title: Text(
                'Your Cart',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.shopping_cart,
                color: Colors.indigo,
              ),
            ),
            ListTile(
              onTap: () => Get.to(FavoriteScreen()),
              title: Text(
                'Your Favorites',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
            ),
          ],
        ),
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
                    return Text('No data');
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

void showBottomsheet() {
  Get.bottomSheet(
    Container(
      color: Colors.white,
      height: 160,
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(
              Icons.nights_stay_rounded,
              color: Colors.black,
            ),
            title: Text(
              'Dark Theem',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Get.changeTheme(
                ThemeData.dark(),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
            title: Text(
              'Light Theem',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Get.changeTheme(
                ThemeData.light(),
              );
            },
          ),
        ],
      ),
    ),
    backgroundColor: Colors.black,
    enableDrag: true,
  );
}
