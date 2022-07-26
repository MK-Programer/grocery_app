import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    "offer1",
    "offer2",
    "offer3",
    "offer4",
  ];

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final color = utils.color;
    return ListView(
      children: [
        SizedBox(
          height: size.height * 0.33,
          child: Swiper(
            itemBuilder: (context, index) {
              return Image.asset(
                "assets/images/offers/${_offerImages[index]}.jpg",
                fit: BoxFit.fill,
              );
            },
            itemCount: _offerImages.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Colors.red,
              ),
            ),
            autoplay: true,
            // control: const SwiperControl(),
          ),
        ),
        TextButton(
          onPressed: () {
            GlobalMethods.navigateTo(
              context: context,
              routName: OnSaleScreen.routeName,
            );
          },
          child: TextWidget(
            text: "View all",
            maxLines: 1,
            color: Colors.blue,
            textSize: 20,
          ),
        ),
        Row(
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: Row(
                children: [
                  TextWidget(
                    text: "On sale".toUpperCase(),
                    color: Colors.red,
                    textSize: 22.0,
                    isTitle: true,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Icon(
                    IconlyLight.discount,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Flexible(
              child: SizedBox(
                height: size.height * 0.24,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const OnSaleWidget();
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: "Our products",
                color: color,
                textSize: 22.0,
                isTitle: true,
              ),
              TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(
                    context: context,
                    routName: FeedScreen.routeName,
                  );
                },
                child: TextWidget(
                  text: "Browse all",
                  maxLines: 1,
                  color: Colors.blue,
                  textSize: 20,
                ),
              ),
            ],
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
            4,
            (index) {
              return const FeedsWidget();
            },
          ),
        ),
      ],
    );
  }
}
