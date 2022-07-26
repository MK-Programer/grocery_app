import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;
  const PriceWidget({
    Key? key,
    required this.salePrice,
    required this.price,
    required this.textPrice,
    required this.isOnSale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final color = utils.color;
    double userPrice = isOnSale ? salePrice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: "${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}\$",
            color: Colors.green,
            textSize: 18.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Visibility(
            visible: isOnSale,
            child: Text(
              "${(price * int.parse(textPrice)).toStringAsFixed(2)}\$",
              style: TextStyle(
                fontSize: 15.0,
                color: color,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
