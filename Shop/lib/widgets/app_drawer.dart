import 'package:flutter/material.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/user_product_screen.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Your Shop'),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
