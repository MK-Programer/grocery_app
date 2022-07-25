import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/categories_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> _catItems = [
    {
      "imgName": "fruits",
      "catText": "Fruites",
      "color": const Color(0xFF538175),
    },
    {
      "imgName": "veg",
      "catText": "Vegetables",
      "color": const Color(0xFFF8A44C),
    },
    {
      "imgName": "spinach",
      "catText": "Herbs",
      "color": const Color(0xFFF7A593),
    },
    {
      "imgName": "nuts",
      "catText": "Nuts",
      "color": const Color(0xFFD3B0E0),
    },
    {
      "imgName": "spices",
      "catText": "Spices",
      "color": const Color(0xFFFDE598),
    },
    {
      "imgName": "grains",
      "catText": "Grains",
      "color": const Color(0xFFB7DFF5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240.0 / 250.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: List.generate(
          _catItems.length,
          (index) {
            return CategoriesWidget(
              imgName: _catItems[index]["imgName"],
              catText: _catItems[index]["catText"],
              passedColor: _catItems[index]["color"],
            );
          },
        ),
      ),
    );
  }
}
