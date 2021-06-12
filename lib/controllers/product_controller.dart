import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shop_x/models/product.dart';
import 'package:shop_x/services/remote_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;

  var favoriteCollection = FirebaseFirestore.instance.collection('Favorites');

  List<Product> productList = List<Product>.empty(growable: true).obs;
  List<Product> favoriteList = List<Product>.empty(growable: true).obs;
  //var productList = List<Product>().obs;
  //var favoriteList = List<Product>().obs;

  @override
  void onInit() {
    fetchProducts(null);
    super.onInit();
  }

  void fetchProducts(String brand) async {
    if (brand == null) {
      brand = "maybelline";
    }
    isLoading(true);
    try {
      var products = await RemoteServices.fetchCategoryProducts(brand);
      //print(products);
      if (products != null) {
        //productList.value = products;
        productList = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void toogleFavorite(Product product, User user) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      favoriteCollection
          .doc(user.uid)
          .collection('${user.displayName} Favorites')
          .add({
        'ProductName': product.name,
        'ProductID': product.id,
      });
      favoriteList.add(product);
    } else if (!product.isFavorite) {
      var todelete = favoriteCollection
          .doc(user.uid)
          .collection('${user.displayName} Favorites')
          .where('ProductID', isEqualTo: product.id);
      //todelete.delete();

      favoriteList.remove(product);
    }

    update();
  }
}
