import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(
          ctx: context,
          routeName: ProductDetails.routeName,
        );
      },
      leading: FancyShimmerImage(
        imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
        width: size.width * 0.2,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: "Title  x12",
        color: color,
        textSize: 18.0,
      ),
      subtitle: const Text("Paid: \$12.8"),
      trailing: TextWidget(
        text: "03/08/2022",
        color: color,
        textSize: 18.0,
      ),
    );
  }
}
