import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
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
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findProdById(productId);
    return GestureDetector(
      onTap: () async {
        // wishListProvider.addRemoveProductsToWishList(productId: productId);
        try {
          if (user == null) {
            GlobalMethods.errorDialog(
                subTitle: "No user found, Please login first",
                context: context);
            return;
          }
          if (isInWishList == false && isInWishList != null) {
            await GlobalMethods.addToWishlist(
              productId: productId,
              context: context,
            );
          } else {
            await wishListProvider.removeOneItem(
              wishlistId:
                  wishListProvider.getwishListItems[getCurrentProduct.id]!.id,
              productId: productId,
            );
          }
          await wishListProvider.fetchWishlist();
        } catch (error) {
        } finally {}
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
