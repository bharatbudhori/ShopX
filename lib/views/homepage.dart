import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/auth_controller.dart';
import 'package:shop_x/controllers/category_controller.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/views/cart_screen.dart';
import 'package:shop_x/views/order_screen.dart';
import 'package:shop_x/views/product_tile.dart';
import 'package:shop_x/views/welcome_screen.dart';
import 'favorite_screen.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage(
    this.user,
  );

  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.pink[100],
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
              showBottomsheet2();
            },
          ),
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {
              showBottomsheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () async {
              await authController.signOutUser().whenComplete(() => {
                    Get.offAll(() => WelcomeScreen()),
                    Get.snackbar(
                      "Loggeg out successfully !",
                      'You have been logged out from your current session.',
                      backgroundColor: Colors.blue,
                    ),
                  });
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
                      user.photoURL == null
                          ? 'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'
                          : user.photoURL,
                    ),
                  ),
                  Text(
                    user.displayName == null ? user.uid : user.displayName,
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
              onTap: () => Get.to(() => CartScreen()),
              title: Text(
                'Your Cart',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.shopping_cart,
                color: Colors.pink,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () => Get.to(() => FavoriteScreen()),
              title: Text(
                'Your Favorites',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () => Get.to(() => OrderScreen()),
              title: Text(
                'Your Orders',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(
                Icons.shopping_bag_outlined,
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
                    return Text(
                      '',
                      style: TextStyle(fontSize: 0),
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

void showBottomsheet2() {
  Get.bottomSheet(
    Container(
      color: Colors.pink[100],
      height: 220,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Get.find<CategoryController>().categoryList.length,
            itemBuilder: (ctx, index) {
              return CategoryTile(
                imageUrl:
                    Get.find<CategoryController>().categoryList[index].imageURL,
                categoryName:
                    Get.find<CategoryController>().categoryList[index].name,
              );
            },
          ),
        ),
      ),
    ),
    backgroundColor: Colors.black,
    enableDrag: true,
  );
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ProductController>().fetchProducts(categoryName);
      },
      child: Container(
        height: 150,
        width: 230,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image(
                image: NetworkImage(imageUrl),
                height: 150,
                width: 230,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
