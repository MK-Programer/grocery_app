import 'package:flutter/material.dart';
import 'package:grocery_app/screens/orders/orders_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/utils.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/OrdersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    final Color color = Utils(context).color;
    return isEmpty
        ? const EmptyScreen(
            imgName: "cart",
            title: "You didn't place any order yet",
            subTitle: "Order something and make me happy :)",
            buttonText: "Shop now",
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
              title: TextWidget(
                text: 'Your Orders (2)',
                color: color,
                isTitle: true,
                textSize: 24.0,
              ),
            ),
            body: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const OrderWidget();
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ),
          );
  }
}
