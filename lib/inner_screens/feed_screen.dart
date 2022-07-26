import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class FeedScreen extends StatefulWidget {
  static const routeName = "/FeedScreen";
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        title: TextWidget(
          text: "All Products",
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset('assets/images/box.png'),
                    ),
                    Text(
                      "No available products, \nstay tuned",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      focusNode: _searchTextFocusNode,
                      controller: _searchTextController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            color: Colors.greenAccent,
                            width: 1.0,
                          ),
                        ),
                        hintText: "Search...",
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchTextController.clear();
                            _searchTextFocusNode.unfocus();
                          },
                          icon: Visibility(
                            visible:
                                _searchTextFocusNode.hasFocus ? true : false,
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: size.width / (size.height * 0.6),
                    // padding: EdgeInsets.zero,
                    // mainAxisSpacing: 10.0,
                    // crossAxisSpacing: 10.0,
                    children: List.generate(
                      40,
                      (index) {
                        return const FeedsWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
