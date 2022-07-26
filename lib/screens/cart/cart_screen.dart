import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return CartWidget();
      },
    );
  }
}
