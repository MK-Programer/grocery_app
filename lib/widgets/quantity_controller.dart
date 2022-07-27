import 'package:flutter/material.dart';

class QuantityController extends StatefulWidget {
  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
