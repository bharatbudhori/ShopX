import 'package:flutter/foundation.dart';

class Orders {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String imageUrl;
  final DateTime dateTime;

  Orders({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
    @required this.dateTime,
  });
}
