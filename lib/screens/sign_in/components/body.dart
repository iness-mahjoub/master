import 'package:flutter/material.dart';
import 'package:flutterp/components/default_button.dart';

import 'package:flutterp/screens/sign_in/components/sign_form.dart';
import 'package:flutterp/size_config.dart';

import '../../../components/no_account_text.dart';
class Body extends StatelessWidget{
  const Body({super.key});

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
           EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(children: [
               SizedBox(
                height: SizeConfig.screenHeight *0.04,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: const Color.fromARGB(255, 19, 18, 18),
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
                
              ),
              const Text(
                "Sign in with you email and password \nor continue with social media ",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight *0.10,
              ),
              SignForm(),
             SizedBox(
                height: SizeConfig.screenHeight *0.18,
              ),
          const NoAccountText()
            ]),
          ),
        ),
      ),
    );
  }
}

