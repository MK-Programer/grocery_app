import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnSaleWidgetState createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final theme = utils.getTheme;
    final color = utils.color;
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://i.ibb.co/F0s3FHQ/Apricots.png",
                    // width: size.width * 0.22,
                    height: size.width * 0.22,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: "1KG",
                        color: color,
                        textSize: 22,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("bag");
                            },
                            child: Icon(
                              IconlyLight.bag2,
                              size: 22.0,
                              color: color,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("heart");
                            },
                            child: Icon(
                              IconlyLight.heart,
                              size: 22.0,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const PriceWidget(),
              const SizedBox(
                height: 5.0,
              ),
              TextWidget(
                text: "Product title",
                color: color,
                textSize: 16.0,
                isTitle: true,
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
