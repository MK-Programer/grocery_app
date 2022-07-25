import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/cart.dart';
import 'package:grocery_app/screens/categories.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/user.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      "page": const HomeScreen(),
      "title": "Home Screen",
    },
    {
      "page": const CategoriesScreen(),
      "title": "Categories Screen",
    },
    {
      "page": const CartScreen(),
      "title": "Cart Screen",
    },
    {
      "page": const UserScreen(),
      "title": "User Screen",
    },
  ];

  int _selectedIndex = 1;

  void _selectedPage(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isDark = themeState.getDarkTheme;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     _pages[_selectedIndex]["title"],
        //   ),
        // ),
        body: _pages[_selectedIndex]["page"],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: isDark ? Colors.white10 : Colors.grey,
          selectedItemColor:
              isDark ? Colors.lightBlue.shade200 : Colors.black87,
          backgroundColor: isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _selectedPage,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(
                _selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category,
              ),
            ),
            BottomNavigationBarItem(
              label: "Cart",
              icon: Icon(
                _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
              ),
            ),
            BottomNavigationBarItem(
              label: "User",
              icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
