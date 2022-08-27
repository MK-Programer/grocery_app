import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  // void addProductsToCart({
  //   required String productId,
  //   required int quantity,
  // }) {
  //   _cartItems.putIfAbsent(
  //     productId,
  //     () => CartModel(
  //       id: DateTime.now().toString(),
  //       productId: productId,
  //       quantity: quantity,
  //     ),
  //   );
  //   notifyListeners(); //! update the listeners
  // }

  void reduceQuantityByOne({required String productId}) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: value.productId,
        quantity: value.quantity - 1,
      ),
    );
    notifyListeners();
  }

  void increaseQuantityByOne({required String productId}) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: value.productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
