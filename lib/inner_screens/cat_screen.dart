import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/feed_items.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreenS";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ProductModel> _listProductSearch = [];
  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productsByCat = productsProvider.findByCategory(catName);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: catName,
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      body: productsByCat.isEmpty
          ? const EmptyProductWidget(
              text: 'No products belong to this category')
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: _searchTextFocusNode,
                        controller: _searchTextController,
                        onChanged: (value) {
                          setState(
                            () {
                              _listProductSearch =
                                  productsProvider.searchQuery(value);
                            },
                          );
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          hintText: "Search...",
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: Visibility(
                            visible:
                                _searchTextFocusNode.hasFocus ? true : false,
                            child: IconButton(
                              onPressed: () {
                                _searchTextController.clear();
                                _searchTextFocusNode.unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: _searchTextFocusNode.hasFocus
                                    ? Colors.red
                                    : color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _searchTextController.text.isNotEmpty &&
                          _listProductSearch.isEmpty
                      ? const EmptyProductWidget(
                          text: 'No products found, please try another keyword',
                        )
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          padding: EdgeInsets.zero,
                          // crossAxisSpacing: 10,
                          childAspectRatio: size.width / (size.height * 0.62),
                          children: List.generate(
                            _searchTextController.text.isNotEmpty
                                ? _listProductSearch.length
                                : productsByCat.length,
                            (index) {
                              return ChangeNotifierProvider.value(
                                value: _searchTextController.text.isNotEmpty
                                    ? _listProductSearch[index]
                                    : productsByCat[index],
                                child: const FeedsWidget(),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
