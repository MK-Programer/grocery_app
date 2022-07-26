import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String routName}) {
    Navigator.pushNamed(context, routName);
  }
}
