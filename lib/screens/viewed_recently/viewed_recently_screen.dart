import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/viewed_provider.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../services/utils.dart';
import 'viewed_recently_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = "/ViewedRecentlyScreen";
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedProdItemsList = viewedProdProvider.getViewedProdListItems.values
        .toList()
        .reversed
        .toList();

    return viewedProdItemsList.isEmpty
        ? const EmptyScreen(
            imgName: "history",
            title: "Your history is empty",
            subTitle: "No products has been viewed yet!",
            buttonText: "Shop now",
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              leading: const BackWidget(),
              title: TextWidget(
                text: 'History (${viewedProdItemsList.length})',
                color: color,
                isTitle: true,
                textSize: 24.0,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                      title: "Empty your history?",
                      subTitle: "Are you sure?",
                      fct: () {
                        viewedProdProvider.clearHistory();
                      },
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
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
              child: ListView.builder(
                itemCount: viewedProdItemsList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: viewedProdItemsList[index],
                    child: const ViewedRecentlyWidget(),
                  );
                },
              ),
            ),
          );
  }
}
