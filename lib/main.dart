import 'package:flutter/material.dart';
import 'package:flutterp/routes.dart';
import 'package:flutterp/screens/splach/splach_screen.dart';
import 'package:flutterp/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: SplachScreen.routeName,
      routes: routes,
    );
  }
}
