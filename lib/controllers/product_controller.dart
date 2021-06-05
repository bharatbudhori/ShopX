import 'package:get/get.dart';
import 'package:shop_x/models/product.dart';
import 'package:shop_x/services/remote_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = List<Product>().obs;
  var favoriteList = List<Product>().obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      var products = await RemoteServices.fetchProducts();
      //print(products);
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void toogleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      favoriteList.add(product);
    } else if (!product.isFavorite) {
      favoriteList.remove(product);
    }
    update();
  }
}
