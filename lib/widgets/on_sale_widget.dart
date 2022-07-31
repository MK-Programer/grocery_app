import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';
import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? isInWishList =
        wishListProvider.getwishListItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetails.routeName,
              arguments: productModel.id,
            );
            // GlobalMethods.navigateTo(
            //   ctx: context,
            //   routeName: ProductDetails.routeName,
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.22,
                      width: size.width * 0.22,
                      boxFit: BoxFit.fill,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          text: productModel.isPiece ? "1Piece" : "1KG",
                          color: color,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: isInCart
                                  ? null
                                  : () {
                                      cartProvider.addProductsToCart(
                                        productId: productModel.id,
                                        quantity: 1,
                                      );
                                    },
                              child: Icon(
                                isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 22.0,
                                color: isInCart ? Colors.green : color,
                              ),
                            ),
                            HeartBTN(
                              productId: productModel.id,
                              isInWishList: isInWishList,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                PriceWidget(
                  isOnSale: productModel.isOnSale,
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: "1",
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 16.0,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
