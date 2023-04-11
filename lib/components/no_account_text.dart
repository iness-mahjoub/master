import 'package:flutter/material.dart';
import 'package:flutterp/screens/sign_up/sign_up_screen.dart';

import '../constant.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../size_config.dart';
class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Text(
         "Dont have an account? ",
         style: TextStyle(fontSize: getProportionateScreenWidth(16)),
       ),
       GestureDetector(
        onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
         child: Text(
           "Sign up ",
           style: TextStyle(fontSize: getProportionateScreenWidth(16), 
           color: kPrimaryColor),
           
         ),
       )
     ],
    );
  }
}

