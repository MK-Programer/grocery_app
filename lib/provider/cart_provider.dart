import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
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
  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    // ignore: unnecessary_null_comparison
    if (userDoc == null) {
      return;
    }
    final length = userDoc.get('userCart').length;
    for (int i = 0; i < length; i++) {
      _cartItems.putIfAbsent(
        userDoc.get('userCart')[i]['productId'],
        () => CartModel(
          id: userDoc.get('userCart')[i]['cartId'],
          productId: userDoc.get('userCart')[i]['productId'],
          quantity: userDoc.get('userCart')[i]['quantity'],
        ),
      );
    }
    notifyListeners();
  }

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

  Future<void> removeOneItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  //! Delete from the firebase
  Future<void> clearOnlineCart() async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': [],
    });
  }

  //! Delete from the ui only
  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
