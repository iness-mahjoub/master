import 'package:flutter/material.dart';

class FavorieList extends StatelessWidget {
  static String routeName = "/favorie_list";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Center(
        child: Text('This is the favorite page.'),
      ),
    );
  }
}