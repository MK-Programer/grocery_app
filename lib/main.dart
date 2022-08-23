import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/provider/wishlist_provider.dart';
import 'package:grocery_app/screens/auth/forget_password_screen.dart';
import 'package:grocery_app/screens/auth/register_screen.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';

import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'inner_screens/cat_screen.dart';
import 'inner_screens/feeds_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text("An error occured"),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) {
                  return themeChangeProvider;
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ProductsProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return CartProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return WishListProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ViewedProdProvider();
                },
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Grocery App',
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  home: const BottomBarScreen(),
                  routes: {
                    OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                    FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                    ProductDetails.routeName: (ctx) => const ProductDetails(),
                    WishListScreen.routeName: (ctx) => const WishListScreen(),
                    OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                    ViewedRecentlyScreen.routeName: (ctx) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                    ForgetPasswordScreen.routeName: (ctx) =>
                        const ForgetPasswordScreen(),
                    CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
