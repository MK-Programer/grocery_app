import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
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
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
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
          onPressed: () {},
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
      ],
    );
  }
}
