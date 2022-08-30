import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/consts/consts.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/provider/orders_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/products_provider.dart';
import 'screens/btm_bar.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FetchScreenState createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Consts.landingImages;
  @override
  void initState() {
    super.initState();
    images.shuffle();
    Future.delayed(
      const Duration(microseconds: 5),
      () async {
        final productsProvider =
            Provider.of<ProductsProvider>(context, listen: false);
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        final wishlistProvider =
            Provider.of<WishListProvider>(context, listen: false);
        final ordersProvider =
            Provider.of<OrdersProvider>(context, listen: false);
        final User? user = authInstance.currentUser;

        if (user == null) {
          await productsProvider.fetchProducts();
          cartProvider.clearLocalCart();
          wishlistProvider.clearLocalWishlist();
          ordersProvider.clearLocalOrders();
        } else {
          await productsProvider.fetchProducts();
          await cartProvider.fetchCart();
          await wishlistProvider.fetchWishlist();
        }

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomBarScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add a splash screen later
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
