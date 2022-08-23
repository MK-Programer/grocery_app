import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishListItems = {};

  Map<String, WishlistModel> get getwishListItems {
    return _wishListItems;
  }

  void addRemoveProductsToWishList({
    required String productId,
  }) {
    if (_wishListItems.containsKey(productId)) {
      removeOneItem(productId: productId);
    } else {
      _wishListItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: DateTime.now().toString(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeOneItem({required String productId}) {
    _wishListItems.remove(productId);
    notifyListeners();
  }

  void clearWishList() {
    _wishListItems.clear();
    notifyListeners();
  }
}
