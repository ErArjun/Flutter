import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/widgets/user_product_item.dart';

import '../widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductSCreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                productData.items[index].id,
                productData.items[index].title,
                productData.items[index].imageUrl,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
