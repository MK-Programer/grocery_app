import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

import '../consts/firebase_consts.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishListItems = {};

  Map<String, WishlistModel> get getwishListItems {
    return _wishListItems;
  }

  // void addRemoveProductsToWishList({
  //   required String productId,
  // }) {
  //   if (_wishListItems.containsKey(productId)) {
  //     removeOneItem(productId: productId);
  //   } else {
  //     _wishListItems.putIfAbsent(
  //       productId,
  //       () => WishlistModel(
  //         id: DateTime.now().toString(),
  //         productId: productId,
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchWishlist() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    // ignore: unnecessary_null_comparison
    if (userDoc == null) {
      return;
    }
    final length = userDoc.get('userWish').length;
    for (int i = 0; i < length; i++) {
      _wishListItems.putIfAbsent(
        userDoc.get('userWish')[i]['productId'],
        () => WishlistModel(
          id: userDoc.get('userWish')[i]['wishlistId'],
          productId: userDoc.get('userWish')[i]['productId'],
        ),
      );
    }
    notifyListeners();
  }

  Future<void> removeOneItem({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistId,
          'productId': productId,
        }
      ])
    });
    _wishListItems.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }

  //! Delete from the firebase
  Future<void> clearOnlineWishlist() async {
    final User? user = authInstance.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': [],
    });
  }

  //! Delete from the ui only
  void clearLocalWishlist() {
    _wishListItems.clear();
    notifyListeners();
  }
}
