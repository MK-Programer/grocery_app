import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/auth/register_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../widgets/auth_button.dart';
import '../../widgets/google_button.dart';
import 'auth_helper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgetPasswordScreen";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  void _forgetPassFCT() {}

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: Stack(
        children: [
          const AuthCarousel(),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const BackWidget(
                  colorPassed: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextWidget(
                  text: "Forget password",
                  color: Colors.white,
                  textSize: 30.0,
                  isTitle: true,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    _forgetPassFCT();
                  },
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: AuthInputStyle.authInputDecoration
                      .copyWith(hintText: "Email address"),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                AuthButton(
                  fct: () {
                    _forgetPassFCT();
                  },
                  buttonText: "Reset now",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
