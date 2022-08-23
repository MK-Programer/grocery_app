import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/viewed_model.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProductModel> _viewedProdListItems = {};

  Map<String, ViewedProductModel> get getViewedProdListItems {
    return _viewedProdListItems;
  }

  void addProductToHistory({
    required String productId,
  }) {
    _viewedProdListItems.putIfAbsent(
      productId,
      () => ViewedProductModel(
        id: DateTime.now().toString(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearHistory() {
    _viewedProdListItems.clear();
    notifyListeners();
  }
}
