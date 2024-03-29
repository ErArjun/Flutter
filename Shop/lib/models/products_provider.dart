// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  /*final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];*/
  var authToken;
  var userId;
  void update(auth) {
    authToken = auth.token;
    userId = auth.userId;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get filteredItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var url = filterByUser
        ? Uri.https(
            'shopflutter-88c80-default-rtdb.firebaseio.com', '/products.json', {
            'auth': '$authToken',
            'orderBy': '"creatorId"',
            'equalTo': '"$userId"',
          })
        : Uri.https(
            'shopflutter-88c80-default-rtdb.firebaseio.com', '/products.json', {
            'auth': '$authToken',
          });
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      url = Uri.https('shopflutter-88c80-default-rtdb.firebaseio.com',
          '/userFavorites/$userId.json', {'auth': '$authToken'});
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[key] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final http.Response response;
    var url = Uri.https('shopflutter-88c80-default-rtdb.firebaseio.com',
        '/products.json', {'auth': '$authToken'});
    try {
      response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'description': product.description,
          'creatorId': userId,
        }),
      );
    } catch (error) {
      rethrow;
    }
    final newProduct = Product(
      id: json.decode(response.body)['name'],
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (id.isNotEmpty) {
      var url = Uri.https('shopflutter-88c80-default-rtdb.firebaseio.com',
          '/products/$id.json', {'auth': '$authToken'});
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'description': product.description,
          }),
        );
      } catch (error) {
        rethrow;
      }
      _items[prodIndex] = product;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    final product = _items[index];
    _items.removeAt(index);
    notifyListeners();
    var url = Uri.https(
        'shopflutter-88c80-default-rtdb.firebaseio.com', '/products/$id.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(index, product);
      notifyListeners();
      throw HttpException('could not delete produts');
    }
  }
}
