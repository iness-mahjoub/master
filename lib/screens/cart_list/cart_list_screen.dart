import 'package:flutter/material.dart';
import 'package:flutterp/screens/cart_list/components/body.dart';

class CartList extends StatelessWidget {
  static String routeName = "/cart_list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart Page'),
      ),
     body: const Body(),
    );
  }
}