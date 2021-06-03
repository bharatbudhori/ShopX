import 'package:flutter/foundation.dart';

class CartItem {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });
}
