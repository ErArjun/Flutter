import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.price,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItem, double price) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          price: price,
          products: cartItem,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
