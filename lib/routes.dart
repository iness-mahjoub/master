import 'package:flutter/widgets.dart';
import 'package:flutterp/screens/cart_list/cart_list_screen.dart';
import 'package:flutterp/screens/categorie_list/categorie_list_screen.dart';
import 'package:flutterp/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutterp/screens/favorie_list/favoorie_list_screen.dart';
import 'package:flutterp/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutterp/screens/login_success/login_success_screen.dart';
import 'package:flutterp/screens/sign_in/sign_in_screen.dart';
import 'package:flutterp/screens/sign_up/sign_up_screen.dart';
import 'package:flutterp/screens/splach/splach_screen.dart';
final Map<String, WidgetBuilder> routes = {
SplachScreen.routeName: (context) =>const SplachScreen(),
SignInScreen.routeName: (context) => SignInScreen(),
ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
SignUpScreen.routeName: (context) => SignUpScreen(),
CompleteProfileScreen.routeName: (context) =>  CompleteProfileScreen(),
FavorieList.routeName:(context) =>  FavorieList(),
CategoryListScreen.routeName:(context) => CategoryListScreen(),
CartList.routeName:(context) => CartList(),
};