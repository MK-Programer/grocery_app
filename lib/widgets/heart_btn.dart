import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final color = utils.color;
    return GestureDetector(
      onTap: () {
        print("heart");
      },
      child: Icon(
        IconlyLight.heart,
        size: 22.0,
        color: color,
      ),
    );
  }
}
