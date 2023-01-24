import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  var authToken;
  var userId;
  void update(auth) {
    authToken = auth.token;
    userId = auth.userId;
  }

  Future<void> addOrder(List<CartItem> cartItem, double total) async {
    final time = DateTime.now();
    http.Response response;
    final url = Uri.https('shopflutter-88c80-default-rtdb.firebaseio.com',
        '/orders/$userId.json', {'auth': '$authToken'});
    try {
      response = await http.post(
        url,
        body: json.encode({
          'price': total,
          'dateTime': time.toIso8601String(),
          'product': cartItem
              .map((item) => {
                    'id': item.id,
                    'title': item.title,
                    'price': item.price,
                    'quantity': item.quantity,
                  })
              .toList(),
        }),
      );
    } catch (error) {
      rethrow;
    }
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          price: total,
          products: cartItem,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    var url = Uri.https('shopflutter-88c80-default-rtdb.firebaseio.com',
        '/orders/$userId.json', {'auth': '$authToken'});
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<OrderItem> loadedOrders = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((key, value) {
        loadedOrders.add(OrderItem(
          id: key,
          price: value['price'],
          products: (value['product'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ))
              .toList(),
          dateTime: DateTime.parse(value['dateTime']),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
