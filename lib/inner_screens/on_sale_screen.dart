import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        title: TextWidget(
          text: "Products on Sale",
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: size.width / (size.height * 0.45),
        // padding: EdgeInsets.zero,
        // mainAxisSpacing: 10.0,
        // crossAxisSpacing: 10.0,
        children: List.generate(
          16,
          (index) {
            return const OnSaleWidget();
          },
        ),
      ),
    );
  }
}
