import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  final String productId;
  final bool? isInWishList;
  const HeartBTN({
    Key? key,
    required this.productId,
    this.isInWishList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishListProvider = Provider.of<WishListProvider>(context);
    final user = authInstance.currentUser;
    return GestureDetector(
      onTap: () {
        if (user == null) {
          GlobalMethods.errorDialog(
              subTitle: "No user found, Please login first", context: context);
          return;
        }
        wishListProvider.addRemoveProductsToWishList(productId: productId);
      },
      child: Icon(
        isInWishList != null && isInWishList == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
            isInWishList != null && isInWishList == true ? Colors.red : color,
      ),
    );
  }
}
