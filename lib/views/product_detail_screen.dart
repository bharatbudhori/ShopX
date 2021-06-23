import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_x/controllers/cart_controller.dart';
import 'package:shop_x/controllers/product_controller.dart';
import 'package:shop_x/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  final Product product;

  ProductDetailScreen({
    this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          //height: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                //color: Colors.red,
                width: double.infinity,
                height: 300,
                child: Hero(
                  tag: product.imageLink,
                  child: Image.network(
                    product.imageLink,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GetBuilder<ProductController>(
                      init: Get.find<ProductController>(),
                      builder: (controller) {
                        return CircleAvatar(
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
                        );
                      },
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
                                dismissDirection:
                                    SnackDismissDirection.HORIZONTAL,
                                overlayBlur: 2,
                              );
                            }
                          },
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                      ),
                      child: Row(
                        children: [
                          Text(
                            product.rating.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                //padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Card(
                  elevation: 15,
                  color: Colors.pink[50],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        //color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
