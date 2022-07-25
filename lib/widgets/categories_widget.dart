import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  final String imgName, catText;
  final Color passedColor;
  const CategoriesWidget({
    Key? key,
    required this.imgName,
    required this.catText,
    required this.passedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        print("Category pressed");
      },
      child: Container(
        // height: screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/cat/$imgName.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextWidget(
              text: catText,
              color: color,
              textSize: 20.0,
              isTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
