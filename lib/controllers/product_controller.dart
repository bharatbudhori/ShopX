import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
    //fetchFavorites();
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

  void toogleFavorite(Product product) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      favoriteList.add(product);

      favoriteCollection
          .doc(currentUser.uid)
          .collection('${currentUser.displayName} Favorites')
          .doc(product.id.toString())
          .set({
        'ProductName': product.name,
        'ProductID': product.id,
        'ImageURL': product.imageLink,
        'Price': product.price,
      });
    } else if (!product.isFavorite) {
      favoriteList.remove(product);

      var todelete = favoriteCollection
          .doc(currentUser.uid)
          .collection('${currentUser.displayName} Favorites')
          .doc(product.id.toString());
      todelete.delete();
    }

    update();
  }
}
