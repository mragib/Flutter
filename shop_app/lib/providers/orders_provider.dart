import 'package:flutter/cupertino.dart';
import './cart_provider.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> product;
  final DateTime date;

  OrderItem({
    required this.id,
    required this.total,
    required this.product,
    required this.date,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        total: total,
        product: cartProduct,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
