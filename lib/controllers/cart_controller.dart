import 'package:shop_x/models/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var adddedToCart = true;
  var cartProductList = List<CartItem>().obs;

  @override
  void onInit() {
    addDummyData();
    super.onInit();
  }

  void addDummyData() {
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
    cartProductList.add(
      CartItem(
        id: 12204,
        name: 'Gucci Bag',
        quantity: 1,
        price: '999',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyvPLRjZ5IM9_GRlZ6Qz_E0JgItqWKFivkr3Ig-FgcQ_ZOUVHIjTQhRHdc4J49Al4C34u9RlPo&usqp=CAc',
      ),
    );
  }

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
  }

  void deletion(CartItem cartItem) {
    cartProductList.removeWhere((element) => element.id == cartItem.id);
    update();
  }
}
