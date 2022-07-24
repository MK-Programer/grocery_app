import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(
              height: 15.0,
            ),
            RichText(
              text: TextSpan(
                text: "Hi,  ",
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "My Name",
                    style: TextStyle(
                      color: color,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextWidget(
              text: "Email@email.com",
              color: color,
              textSize: 18.0,
              isTitle: false,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              thickness: 2.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            _listTiles(
              title: "Address",
              icon: IconlyLight.profile,
              subTitle: "My subtitle",
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Orders",
              icon: IconlyLight.bag,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Wishlist",
              icon: IconlyLight.heart,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Forget password",
              icon: IconlyLight.unlock,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Viewed ",
              icon: IconlyLight.show,
              onPressed: () {},
              color: color,
            ),
            SwitchListTile(
              title: TextWidget(
                text: themeState.getDarkTheme ? "Dark mode" : "Light mode",
                color: color,
                textSize: 18.0,
              ),
              secondary: Icon(
                themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
              ),
              value: themeState.getDarkTheme,
              onChanged: (bool value) {
                setState(
                  () {
                    themeState.setDarkTheme = value;
                  },
                );
              },
            ),
            _listTiles(
              title: "Logout ",
              icon: IconlyLight.logout,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Wishlist",
              icon: IconlyLight.heart,
              onPressed: () {},
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTiles({
    required String title,
    String? subTitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22.0,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subTitle ?? "",
        color: color,
        textSize: 18.0,
      ),
      trailing: const Icon(
        IconlyLight.arrowRight2,
      ),
      onTap: () {
        onPressed();
      },
    );
  }
}
