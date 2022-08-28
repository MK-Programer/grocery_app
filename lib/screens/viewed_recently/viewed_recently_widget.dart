import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/viewed_model.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_consts.dart';
import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewedRecentlyWidgetState createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final Size size = Utils(context).getScreenSize;

    final viewedProdModel = Provider.of<ViewedProductModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProduct =
        productProvider.findProdById(viewedProdModel.productId);

    double usedPrice =
        viewedProduct.isOnSale ? viewedProduct.salePrice : viewedProduct.price;
    bool? isInCart = cartProvider.getCartItems.containsKey(viewedProduct.id);
    final user = authInstance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: viewedProduct.id,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: viewedProduct.imageUrl,
              height: size.width * 0.27,
              width: size.width * 0.25,
              boxFit: BoxFit.fill,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: viewedProduct.title,
                  color: color,
                  textSize: 24.0,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextWidget(
                  text: "\$${usedPrice.toStringAsFixed(2)}",
                  color: color,
                  textSize: 20.0,
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: isInCart
                    ? null
                    : () async {
                        if (user == null) {
                          GlobalMethods.errorDialog(
                              subTitle: "No user found, Please login first",
                              context: context);
                          return;
                        }
                        // cartProvider.addProductsToCart(
                        //     productId: viewedProduct.id, quantity: 1);
                        GlobalMethods.addToCart(
                          productId: viewedProduct.id,
                          quantity: 1,
                          context: context,
                        );
                        await cartProvider.fetchCart();
                      },
                child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isInCart ? Icons.check : IconlyBold.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
