import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_x/models/cart.dart';
import 'package:get/get.dart';
import 'package:shop_x/models/orders.dart';
import '../views/login_screen.dart';
import 'orders_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

final UserController userController = Get.put(UserController());
final OrderController orderController = Get.put(OrderController());
User currentUser = userController.currentUser;

class CartController extends GetxController {
  var cartCollection1 = FirebaseFirestore.instance
      .collection('Cart')
      .doc(currentUser.uid)
      .collection('${currentUser.displayName} cart');
  var orderCollection = FirebaseFirestore.instance
      .collection('Order')
      .doc(currentUser.uid)
      .collection('${currentUser.displayName} orders');
  Razorpay razorpay;
  var cartCollection = FirebaseFirestore.instance.collection('Cart');
  var adddedToCart = true;
  var totalPrice = 0.00.obs;
  List<CartItem> cartProductList = List<CartItem>.empty(growable: true).obs;
  //var cartProductList = List<CartItem>().obs;

  @override
  void onInit() async {
    print('Cart Controller init called');
    //addDummyData();
    //print(double.parse('56.008'));
    cartProductList.clear();
    fetchCartItems().then((_) {
      fetchTotal();
    });

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentFailure);
    razorpay..on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    //fetchTotal();
    super.onInit();
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_L4FIsJm66e5SKK',
      'amount': totalPrice * 100,
      'name': 'ShopX',
      'description': 'Your Order',
      'prefill': {'email': currentUser.email},
      'external': {
        'wallets': ['paytm']
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print('Payment Success');
    Get.snackbar(
      'Payment Successfull  ${response.paymentId}',
      'Your payment for your order was successfull',
      backgroundColor: Colors.green,
      overlayBlur: 2,
    );

    addToOrders(
      dateTime: DateTime.now(),
      price: totalPrice.toString(),
      orderListItem: cartProductList,
    );

    await orderCollection.add(
      {
        'dateTime': DateTime.now(),
        'totalPrice': totalPrice.toString(),
        //'orderItems': cartController.cartProductList,
      },
    ).whenComplete(() async {
      var snapshots = await FirebaseFirestore.instance
          .collection('Cart')
          .doc(currentUser.uid)
          .collection('${currentUser.displayName} cart')
          .get();
      for (var doc in snapshots.docs) {
        clearCart();
        await doc.reference.delete();
      }
    });
  }

  void handlerPaymentFailure(PaymentFailureResponse response) {
    print('Payment Failed');
    Get.snackbar(
      'ERROR: ${response.code.toString()} - ${response.message}',
      'Your payment for your order was failed',
      backgroundColor: Colors.red,
      overlayBlur: 2,
    );
  }

  void handlerExternalWallet() {
    print('External Wallet');
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
    totalPrice += double.parse(price);
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

  Future<void> fetchCartItems() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUser.uid)
        .collection('${currentUser.displayName} cart')
        .get();

    snapshot.docs.forEach((element) {
      cartProductList.add(CartItem(
        id: element['ProductID'],
        name: element['ProductName'],
        price: element['Price'],
        imageUrl: element['ImageUrl'],
        quantity: element['Quantity'],
      ));
    });
    update();
  }

  void clearCart() {
    cartProductList.clear();
    update();
  }

  void deletion(int id, String price) {
    cartProductList.removeWhere((element) => element.id == id);
    //cartProductList.removeAt(index);
    totalPrice -= double.parse(price);
    // cartCollection
    //     .doc(currentUser.uid)
    //     .collection('${currentUser.displayName} cart')
    //     .doc(id.toString())
    //     .delete();

    //cartCollection.doc()
    update();
  }

  void addToOrders({
    //int id,
    //String name,
    //int quantity,
    //String imageUrl,
    String price,
    DateTime dateTime,
    List<CartItem> orderListItem,
  }) {
    orderController.orderList.insert(
        0,
        Orders(
          //id: id,
          // name: name,
          // quantity: quantity,
          price: price,
          // imageUrl: imageUrl,
          dateTime: dateTime,
          orderListItem: orderListItem,
        ));
  }

  void fetchTotal() {
    for (var i = 0; i < cartProductList.length; i++) {
      totalPrice += double.parse(cartProductList[i].price);
    }
  }
}
