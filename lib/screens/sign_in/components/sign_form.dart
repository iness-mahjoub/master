import 'package:flutter/material.dart';
import 'package:flutterp/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constant.dart';
import '../../../size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
class SignForm extends StatefulWidget {
@override
_SignFormState createState() => _SignFormState();}

class _SignFormState extends State<SignForm> {
  final _formkey = GlobalKey<FormState>();
 late String email;
 late String password;
 bool remember = false;
  final List<String> errors= [];
  @override
  Widget build(BuildContext context){
    
    return Form(
      key: _formkey,
      child: Column(
        children: [
      
        buildEmailFormField(),
        SizedBox(height: getProportionateScreenHeight(20)),
         buildPasswordFormField(),
         SizedBox(height: getProportionateScreenHeight(20)),
         
         Row(
          children: [
            Checkbox(
              value: remember, 
              activeColor: kPrimaryColor,
              onChanged: (value){
              setState(() {
                remember = value!;
              
              });
            }
            ),
            const Text("Remember me"),
            const Spacer(),
            GestureDetector(
              onTap: () =>Navigator.popAndPushNamed(
          context, ForgotPasswordScreen.routeName),
              child: const Text(
                "Forgot Password ",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )

          ],
         ),
         FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
         DefaultButton(
          text:"continue",
          color: Colors.blue,
          press: (){
            if(_formkey.currentState!.validate()){
              _formkey.currentState!.save();
              Navigator.pushNamed(context,LoginSuccessScreen.routeName);
            }
          }
         )
      ]),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue!,
        onChanged: (value){
          if (value.isNotEmpty && errors.contains(kPassNullError)){
          setState(() {
            errors.remove(kPassNullError);
          });
        
        }
        else if (value.length >= 8 && 
        errors.contains(kShortPassError)){
          setState(() {
            errors.remove(kShortPassError);
          });
         
        }
        return null;
        },
        validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)){
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        }
        else if (value.length < 8 && 
        !errors.contains(kShortPassError)){
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
        return null;
        },
        keyboardType: TextInputType.emailAddress,
        
        decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock),
           ),
      );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) =>email = newValue!,
        onChanged: (value){
           if (value.isNotEmpty && errors.contains(kEmailNullError)){
          setState(() { 
            errors.remove(kEmailNullError);
          });
        }
        else if (emailValidatorRegExp.hasMatch(value)&& 
        errors.contains(kInvalidEmailError)){
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
        },
        validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)){
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        }
        else if (!emailValidatorRegExp.hasMatch(value)&& 
        !errors.contains(kInvalidEmailError)){
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
        },
        decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Enter your Email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email),
           ),
      );
  }
}

