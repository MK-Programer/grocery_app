import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class BackWidget extends StatelessWidget {
  final Color? colorPassed;
  final Function? fct;
  const BackWidget({
    Key? key,
    this.colorPassed,
    this.fct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return InkWell(
      onTap: () {
        if (fct != null) {
          fct!();
        }
        Navigator.canPop(context) ? Navigator.of(context).pop() : null;
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Icon(
        IconlyLight.arrowLeft2,
        color: colorPassed ?? color,
        size: 24.0,
      ),
    );
  }
}
