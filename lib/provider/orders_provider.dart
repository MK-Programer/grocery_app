import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/orders_model.dart';

import '../consts/firebase_consts.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    User? user = authInstance.currentUser;

    await FirebaseFirestore.instance.collection('orders').get().then(
      (QuerySnapshot ordersSnapshot) {
        _orders = [];
        // _orders.clear();
        // ignore: avoid_function_literals_in_foreach_calls
        ordersSnapshot.docs.forEach(
          (element) {
            if (element.id.contains(user!.uid)) {
              _orders.insert(
                0,
                OrderModel(
                  orderId: element.get('orderId'),
                  userId: element.get('userId'),
                  productId: element.get('productId'),
                  userName: element.get('userName'),
                  price: element.get('price').toString(),
                  imageUrl: element.get('imageUrl'),
                  quantity: element.get('quantity').toString(),
                  orderDate: element.get('orderDate'),
                ),
              );
            }
          },
        );
      },
    );
    notifyListeners();
  }
}
