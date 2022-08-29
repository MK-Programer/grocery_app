import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final ordersModel = Provider.of<OrderModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productProvider.findProdById(ordersModel.productId);

    return ListTile(
      onTap: () {
        GlobalMethods.navigateTo(
          ctx: context,
          routeName: ProductDetails.routeName,
        );
      },
      leading: FancyShimmerImage(
        imageUrl: ordersModel.imageUrl,
        width: size.width * 0.2,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: "${getCurrentProduct.title}  x${ordersModel.quantity}",
        color: color,
        textSize: 18.0,
      ),
      subtitle:
          Text("Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}"),
      trailing: TextWidget(
        text: orderDateToShow,
        color: color,
        textSize: 18.0,
      ),
    );
  }
}
