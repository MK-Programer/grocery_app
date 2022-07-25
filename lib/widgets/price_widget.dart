import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final color = utils.color;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
            text: "1.59\$",
            color: Colors.green,
            textSize: 22.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            "2.59\$",
            style: TextStyle(
              fontSize: 15.0,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
