import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/wishlist_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/wishlist_provider.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).getScreenSize;
    final wishListModel = Provider.of<WishlistModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListProduct =
        productProvider.findProdById(wishListModel.productId);
    bool? isInWishList =
        wishListProvider.getwishListItems.containsKey(wishListProduct.id);

    double usedPrice = wishListProduct.isOnSale
        ? wishListProduct.salePrice
        : wishListProduct.price;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: wishListProduct.id,
          );
        },
        child: Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: color,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  // width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: wishListProduct.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          HeartBTN(
                            productId: wishListProduct.id,
                            isInWishList: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: wishListProduct.title,
                      color: color,
                      textSize: 20.0,
                      maxLines: 2,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextWidget(
                      text: "\$${usedPrice.toStringAsFixed(2)}",
                      color: color,
                      textSize: 18.0,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
