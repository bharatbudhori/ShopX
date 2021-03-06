import 'package:http/http.dart' as http;
import 'package:shop_x/models/product.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>> fetchProducts() async {
    var response = await client.get(
      Uri.parse(
          "http://makeup-api.herokuapp.com/api/v1/products.json?brand=l'oreal&brand=maybelline"),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<List<Product>> fetchCategoryProducts(String brand) async {
    if (brand == null) {
      brand = 'maybelline';
    }
    var response = await client.get(
      Uri.parse(
          "http://makeup-api.herokuapp.com/api/v1/products.json?brand=l'oreal&brand=$brand"),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
