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
  final TextEditingController _addressTextController = TextEditingController();
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

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
              onPressed: () async {
                await _showAddressDialog();
              },
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
              title: "Viewed ",
              icon: IconlyLight.show,
              onPressed: () {},
              color: color,
            ),
            _listTiles(
              title: "Forget password",
              icon: IconlyLight.unlock,
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
              onPressed: () async {
                await _showLogoutDialog();
              },
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Update",
          ),
          content: TextField(
            // onChanged: (value) {
            //   print("Address Text ${_addressTextController.text}");
            // },
            controller: _addressTextController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Your address",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                "Update",
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20.0,
                width: 20.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                "Sign out",
              ),
            ],
          ),
          content: const Text(
            "Do you want to sign out?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                text: "Cancel",
                color: Colors.cyan,
                textSize: 18.0,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: TextWidget(
                text: "Ok",
                color: Colors.red,
                textSize: 18.0,
              ),
            ),
          ],
        );
      },
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
