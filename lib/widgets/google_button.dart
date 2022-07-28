import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                "assets/images/google.png",
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            TextWidget(
              text: "Sign in with google",
              color: Colors.white,
              textSize: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
