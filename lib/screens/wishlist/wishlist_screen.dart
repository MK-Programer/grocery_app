import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = "/WishListScreen";
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    bool isEmpty = true;
    return isEmpty
        ? const EmptyScreen(
            imgName: "wishlist",
            title: "Your wishlist is empty",
            subTitle: "Explore more and shortlist some items",
            buttonText: "Add a wish",
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
              title: TextWidget(
                text: 'Wishlist (2)',
                color: color,
                isTitle: true,
                textSize: 22,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      title: "Empty your wishlist?",
                      subTitle: "Are you sure?",
                      fct: () {},
                      context: context,
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              itemCount: 3,
              crossAxisCount: 2,
              // mainAxisSpacing: 16.0,
              // crossAxisSpacing: 20.0,
              itemBuilder: (context, index) {
                return const WishListWidget();
              },
            ),
          );
  }
}
