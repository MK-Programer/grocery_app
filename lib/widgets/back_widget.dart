import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return InkWell(
      onTap: () {
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Icon(
        IconlyLight.arrowLeft2,
        color: color,
        size: 24.0,
      ),
    );
  }
}
