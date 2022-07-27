import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          GlobalMethods.navigateTo(
            ctx: context,
            routeName: ProductDetails.routeName,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FancyShimmerImage(
              imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
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
                  text: "Title",
                  color: color,
                  textSize: 24.0,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextWidget(
                  text: "\$12.88",
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
                onTap: () {},
                child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.green,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.add,
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
