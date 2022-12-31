import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double amount = 0;
    _items.forEach((key, item) {
      amount += item.quantity * item.price;
    });
    return amount;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (currentValue) => CartItem(
                id: currentValue.id,
                title: currentValue.title,
                quantity: currentValue.quantity + 1,
                price: currentValue.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
