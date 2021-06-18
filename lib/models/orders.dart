import 'package:flutter/foundation.dart';
import 'package:shop_x/models/cart.dart';

class Orders {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String imageUrl;
  final DateTime dateTime;
  final List<CartItem> orderList;

  Orders({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
    @required this.dateTime,
    @required this.orderList,
  });
}
