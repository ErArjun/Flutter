import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders.dart';
import 'package:shop/widgets/orders_items.dart';

import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders')),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: ((context, index) => OrdersItems(orderData.orders[index])),
      ),
      drawer: AppDrawer(),
    );
  }
}
