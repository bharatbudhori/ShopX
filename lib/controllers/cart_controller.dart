import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_x/models/cart.dart';
import 'package:get/get.dart';
import '../views/login_screen.dart';

final UserController userController = Get.put(UserController());
User currentUser = userController.currentUser;

class CartController extends GetxController {
  var cartCollection = FirebaseFirestore.instance.collection('Cart');
  var adddedToCart = true;
  List<CartItem> cartProductList = List<CartItem>.empty(growable: true).obs;
  //var cartProductList = List<CartItem>().obs;

  @override
  void onInit() {
    //addDummyData();
    super.onInit();
  }

  // void addDummyData() {
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  //   cartProductList.add(
  //     CartItem(
  //       id: 12204,
  //       name: 'Gucci Bag',
  //       quantity: 1,
  //       price: '999',
  //       imageUrl:
  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
  //     ),
  //   );
  // }

  void addProductsToCart(
    int id,
    String name,
    int quantity,
    String imageURL,
    String price,
  ) {
    cartProductList.add(
      CartItem(
          id: id,
          name: name,
          quantity: quantity,
          price: price,
          imageUrl: imageURL),
    );
    cartCollection
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart')
        .doc(id.toString())
        .set({
      'ProductName': name,
      'ProductID': id,
      'Quantity': quantity,
      'Price': price,
      'ImageUrl': imageURL,
    });
    update();
  }

  void deletion(int index, int id) {
    cartProductList.removeAt(index);
    cartCollection
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart')
        .doc(id.toString())
        .delete();

    //cartCollection.doc()
    update();
  }
}
