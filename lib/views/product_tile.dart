import 'package:flutter/material.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/models/product.dart';
import 'package:get/get.dart';
//import 'package:shop_x/services/admob_services.dart';
import 'package:shop_x/views/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  //final ProductController productController = Get.put(ProductController());
  final Product product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    //AdMobService.createInterad();
                    Get.to(() => ProductDetailScreen(
                          product: product,
                        ));
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Hero(
                      tag: product.imageLink,
                      child: Image.network(
                        product.imageLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GetBuilder<ProductController>(
                    init: Get.find<ProductController>(),
                    builder: (controller) {
                      return Positioned(
                        right: 0,
                        child: //Obx(
                            //() =>
                            CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: controller.favProductList
                                    .any((element) => element.id == product.id)
                                ? Icon(Icons.favorite_rounded)
                                : Icon(Icons.favorite_border),
                            onPressed: () {
                              controller.toogleFavorite(
                                name: product.name,
                                product: product,
                                imageUrl: product.imageLink,
                                prodID: product.id,
                                price: product.price,
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              style:
                  TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            if (product.rating != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '\$${product.price}',
                    style: TextStyle(fontSize: 32, fontFamily: 'avenir'),
                  ),
                ),
                GetBuilder(
                  init: cartController,
                  builder: (controller) {
                    return IconButton(
                      icon: cartController.cartProductList
                              .any((element) => element.id == product.id)
                          ? Icon(Icons.shopping_cart)
                          : Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        if (cartController.cartProductList
                            .any((element) => element.id == product.id)) {
                          Get.defaultDialog(
                            title: 'Item Already present in your Cart.',
                            content: Text('Tap on screen to close dialog.'),
                          );
                        } else {
                          cartController.addProductsToCart(
                            product.id,
                            product.name,
                            1,
                            product.imageLink,
                            product.price,
                          );

                          print(product.name);
                          Get.snackbar(
                            product.name,
                            'Added to Cart',
                            backgroundColor: Colors.pink[100],
                            barBlur: 12,
                            duration: Duration(milliseconds: 1500),
                            dismissDirection: SnackDismissDirection.HORIZONTAL,
                            overlayBlur: 2,
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
