import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/auth/forget_password_screen.dart';
import 'package:grocery_app/services/global_methods.dart';

import '../../consts/consts.dart';

class AuthInputStyle {
  static var authInputDecoration = const InputDecoration(
    hintText: "hint text",
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  );
}

class AuthCarousel extends StatefulWidget {
  const AuthCarousel({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthCarouselState createState() => _AuthCarouselState();
}

class _AuthCarouselState extends State<AuthCarousel> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          Consts.landingImages[index],
          fit: BoxFit.cover,
        );
      },
      autoplay: true,
      duration: 800,
      autoplayDelay: 8000,
      itemCount: Consts.landingImages.length,
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          GlobalMethods.navigateTo(
            ctx: context,
            routeName: ForgetPasswordScreen.routeName,
          );
        },
        child: const Text(
          "Forget password?",
          maxLines: 1,
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 18.0,
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
