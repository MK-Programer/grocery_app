import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/provider/products_provider.dart';
// import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';
import '../services/global_methods.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = "/ProductDetails";
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextEditingController _quantityTextController =
      TextEditingController(text: "1");

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final user = authInstance.currentUser;
    final cartProvider = Provider.of<CartProvider>(context);

    final wishListProvider = Provider.of<WishListProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findProdById(productId);

    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;

    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);

    bool? isInWishList =
        wishListProvider.getwishListItems.containsKey(getCurrentProduct.id);

    // final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(
          fct: () {
            // viewedProdProvider.addProductToHistory(productId: productId);
          },
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrentProduct.imageUrl,
              boxFit: BoxFit.scaleDown,
              width: size.width,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: getCurrentProduct.title,
                          color: color,
                          textSize: 25.0,
                          isTitle: true,
                        ),
                        HeartBTN(
                          productId: getCurrentProduct.id,
                          isInWishList: isInWishList,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "\$${usedPrice.toStringAsFixed(2)}",
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: getCurrentProduct.isPiece ? "/Piece" : "/Kg",
                          color: color,
                          textSize: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: getCurrentProduct.isOnSale ? true : false,
                          child: Text(
                            '\$${getCurrentProduct.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: color,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(63, 200, 101, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextWidget(
                            text: "Free delivery",
                            color: Colors.white,
                            textSize: 20.0,
                            isTitle: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _quantityController(
                        fct: () {
                          setState(
                            () {
                              if (_quantityTextController.text == "1") {
                                return;
                              } else {
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController.text) -
                                            1)
                                        .toString();
                              }
                            },
                          );
                        },
                        color: Colors.red,
                        icon: CupertinoIcons.minus,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          key: const ValueKey("quantity"),
                          textAlign: TextAlign.center,
                          controller: _quantityTextController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(
                              () {
                                if (value.isEmpty) {
                                  _quantityTextController.text = '1';
                                } else {
                                  return;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      _quantityController(
                        fct: () {
                          setState(
                            () {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) + 1)
                                      .toString();
                            },
                          );
                        },
                        color: Colors.green,
                        icon: CupertinoIcons.plus,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Total",
                                color: Colors.red.shade300,
                                textSize: 20.0,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  TextWidget(
                                    text: "\$${totalPrice.toStringAsFixed(2)}/",
                                    color: color,
                                    textSize: 20.0,
                                    isTitle: true,
                                  ),
                                  TextWidget(
                                    text:
                                        "${_quantityTextController.text}${getCurrentProduct.isPiece ? " Piece" : " Kg"}${getCurrentProduct.isPiece && (int.parse(_quantityTextController.text) > 1) ? 's' : ''}",
                                    color: color,
                                    textSize: 16.0,
                                    isTitle: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Flexible(
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                            child: InkWell(
                              onTap: isInCart
                                  ? null
                                  : () async {
                                      if (user == null) {
                                        GlobalMethods.errorDialog(
                                            subTitle:
                                                "No user found, Please login first",
                                            context: context);
                                        return;
                                      }
                                      // cartProvider.addProductsToCart(
                                      //   productId: getCurrentProduct.id,
                                      //   quantity: int.parse(
                                      //     _quantityTextController.text,
                                      //   ),
                                      // );
                                      await GlobalMethods.addToCart(
                                        productId: getCurrentProduct.id,
                                        quantity: int.parse(
                                          _quantityTextController.text,
                                        ),
                                        context: context,
                                      );
                                      await cartProvider.fetchCart();
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextWidget(
                                  text: isInCart ? "In cart" : "Add to cart",
                                  color: Colors.white,
                                  textSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
