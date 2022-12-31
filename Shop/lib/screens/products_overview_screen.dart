import 'package:flutter/material.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../models/cart_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewSCreen extends StatefulWidget {
  @override
  State<ProductsOverviewSCreen> createState() => _ProductsOverviewSCreenState();
}

class _ProductsOverviewSCreenState extends State<ProductsOverviewSCreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selectedData) {
              setState(() {
                if (selectedData == FilterOptions.Favorites) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('show all'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: ((context, cart, ch) => Badge(
                value: cart.items.length.toString(), child: ch as Widget)),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
