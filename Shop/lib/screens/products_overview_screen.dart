import 'package:flutter/material.dart';
import 'package:shop/widgets/products_grid.dart';

class ProductsOverviewSCreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: const ProductsGrid(),
    );
  }
}
