import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/screens/auth/forget_password_screen.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  final user = authInstance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  bool _isLoading = false;
  String? _email;
  String? _name;
  String? _address;
  Future<void> getUserData() async {
    setState(() => _isLoading = true);
    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }
    try {
      String uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // ignore: unnecessary_null_comparison
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        _address = userDoc.get('shippingAddress');
        _addressTextController.text = userDoc.get('shippingAddress');
      }
    } catch (error) {
      setState(() => _isLoading = false);
      GlobalMethods.errorDialog(subTitle: '$error', context: context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hi,  ',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: _name ?? 'FullName',
                          style: TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('My name is pressed');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    text: _email ?? 'Email Address',
                    color: color,
                    textSize: 18,
                    // isTitle: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Address 2',
                    subtitle: _address ?? 'Shipping Address',
                    icon: IconlyLight.profile,
                    onPressed: () async {
                      await _showAddressDialog();
                    },
                    color: color,
                  ),
                  _listTiles(
                    title: 'Orders',
                    icon: IconlyLight.bag,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: OrdersScreen.routeName,
                      );
                    },
                    color: color,
                  ),
                  _listTiles(
                    title: 'Wishlist',
                    icon: IconlyLight.heart,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: WishListScreen.routeName,
                      );
                    },
                    color: color,
                  ),
                  _listTiles(
                    title: 'Viewed',
                    icon: IconlyLight.show,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                        ctx: context,
                        routeName: ViewedRecentlyScreen.routeName,
                      );
                    },
                    color: color,
                  ),
                  _listTiles(
                    title: 'Forget password',
                    icon: IconlyLight.unlock,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen(),
                        ),
                      );
                    },
                    color: color,
                  ),
                  SwitchListTile(
                    title: TextWidget(
                      text:
                          themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                      color: color,
                      textSize: 18,
                      // isTitle: true,
                    ),
                    secondary: Icon(
                      themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    onChanged: (bool value) {
                      setState(
                        () {
                          themeState.setDarkTheme = value;
                        },
                      );
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listTiles(
                    title: user == null ? 'Login' : 'Logout',
                    icon: user == null ? IconlyLight.login : IconlyLight.logout,
                    onPressed: user == null
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          }
                        : () {
                            GlobalMethods.warningDialog(
                              title: "Sign out",
                              subTitle: "Do you want to sign out",
                              fct: () async {
                                await authInstance.signOut();
                                await googleSignIn.signOut();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              context: context,
                            );
                          },
                    color: color,
                  ),
                  // listTileAsRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            // onChanged: (value) {
            //   print('_addressTextController.text ${_addressTextController.text}');
            // },
            controller: _addressTextController,
            maxLines: 5,
            decoration:
                const InputDecoration(hintText: "Your shipping address"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (user == null) {
                  Navigator.pop(context);
                  GlobalMethods.errorDialog(
                      subTitle: "No user found, Please login first",
                      context: context);
                  return;
                }
                String uid = user!.uid;
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({
                    'shippingAddress': _addressTextController.text,
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  setState(() => _address = _addressTextController.text);
                } catch (error) {
                  GlobalMethods.errorDialog(
                      subTitle: '$error', context: context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        // isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
