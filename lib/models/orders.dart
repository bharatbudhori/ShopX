import 'package:flutter/foundation.dart';
import 'package:shop_x/models/cart.dart';

class Orders {
  // final int id;
  // final String name;
  // final int quantity;
  // final String imageUrl;
  final String price;
  final DateTime dateTime;
  final List<CartItem> orderList;

  Orders({
    // @required this.id,
    // @required this.name,
    // @required this.quantity,
    // @required this.imageUrl,
    @required this.price,
    @required this.dateTime,
    @required this.orderList,
  });
}
