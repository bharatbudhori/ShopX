import 'package:flutter/foundation.dart';

class Favorite {
  final int id;
  final String name;
  final String price;
  final String imageUrl;

  Favorite({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
  });
}
