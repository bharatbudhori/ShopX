import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_x/models/favorite.dart';
import 'package:shop_x/models/product.dart';
import 'package:shop_x/services/remote_services.dart';
import '../views/login_screen.dart';

final UserController userController = Get.put(UserController());
User currentUser = userController.currentUser;

class ProductController extends GetxController {
  var isLoading = true.obs;

  var favoriteCollection = FirebaseFirestore.instance.collection('Favorites');

  List<Product> productList = List<Product>.empty(growable: true).obs;
  List<Product> favoriteList = List<Product>.empty(growable: true).obs;
  List<Favorite> favProductList = List<Favorite>.empty(growable: true).obs;

  //List data = [];
  //var productList = List<Product>().obs;
  //var favoriteList = List<Product>().obs;

  // await Firestore.instance.collection("restaurant").getDocuments().then(
  //         (QuerySnapshot snapshot) => snapshot.documents.forEach(
  //           (f) => loadedList.insert(
  //             0,
  //             RestaurantFoodList(
  //                 id: f.data['id'],
  //                 imageUrl: f.data['imageUrl'],
  //                 title: f.data['title'],
  //                 items: [f.data['items']]

  //             ),
  //           ),
  //         ),
  //   );

  // void fetchFavorites() async {
  //   var collectionReferece = favoriteCollection
  //       .doc(currentUser.uid)
  //       .collection('${currentUser.displayName} Favorites');

  //   collectionReferece.get().then((collectionSnapshot) {
  //     data.insert(0, collectionSnapshot.docs);
  //   });

  //   //print(data);
  // }

  @override
  void onInit() {
    fetchProducts(null);
    favProductList.clear();
    fetchFavorites();

    //print(favoriteList);
    //fetchFavorites();
    super.onInit();
  }

  void fetchProducts(String brand) async {
    print(favoriteList.length);

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

  void toogleFavorite({
    Product product,
    String imageUrl,
    String name,
    String price,
    int prodID,
  }) async {
    //product.isFavorite = !product.isFavorite;
    if (favProductList.any((element) => element.id == product.id)) {
      favoriteList.remove(product);
      favProductList.removeWhere(
        (element) => element.imageUrl == imageUrl,
      );

      favoriteCollection
          .doc(currentUser.uid)
          .collection('${currentUser.displayName} Favorites')
          .doc(product.id.toString())
          .delete();
    } else {
      favoriteList.add(product);
      favProductList.insert(
          0,
          Favorite(
              id: product.id,
              name: product.name,
              price: product.price,
              imageUrl: product.imageLink));

      favoriteCollection
          .doc(currentUser.uid)
          .collection('${currentUser.displayName} Favorites')
          .doc(product.id.toString())
          .set({
        'ProductName': name,
        'ProductID': prodID,
        'ImageURL': imageUrl,
        'Price': price,
      });
    }

    update();
  }

  void fetchFavorites() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} Favorites')
        .get();

    snapshot.docs.forEach((element) {
      favProductList.insert(
          0,
          Favorite(
            id: element['ProductID'],
            name: element['ProductName'],
            price: element['Price'],
            imageUrl: element['ImageURL'],
          ));
    });
    update();
  }
}
