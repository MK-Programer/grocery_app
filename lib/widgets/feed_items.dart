import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  final String imageUrl, title;
  const FeedsWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            GlobalMethods.navigateTo(
              ctx: context,
              routeName: ProductDetails.routeName,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: widget.imageUrl,
                height: size.width * 0.21,
                width: size.width * 0.2,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: widget.title,
                        color: color,
                        textSize: 18,
                        isTitle: true,
                        maxLines: 1,
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: HeartBTN(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: PriceWidget(
                        salePrice: 2.99,
                        price: 5.9,
                        textPrice: _quantityTextController.text,
                        isOnSale: true,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: FittedBox(
                              child: TextWidget(
                                text: 'KG',
                                color: color,
                                textSize: 18,
                                isTitle: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "1",
                              ),
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              onChanged: (value) {
                                setState(
                                  () {
                                    if (value.isEmpty) {
                                      _quantityTextController.text = "1";
                                    } else {
                                      return;
                                    }
                                  },
                                );
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: 'Add to cart',
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
