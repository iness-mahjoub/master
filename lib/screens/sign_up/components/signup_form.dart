import 'package:flutter/material.dart';
import 'package:flutterp/screens/complete_profile/complete_profile_screen.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constant.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>{
  final _formKey = GlobalKey<FormState>();
 String? email;
  String? password;
  String? Conform_password;
  final List<String> errors =[];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override 
  Widget build(BuildContext context){
    return Form(
      key: _formKey, // add this line to associate the form with the GlobalKey
      child: Column(
        children: [
          
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          builfConfPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          
          DefaultButton(
            text: "continue", 
            press: (){
              if(_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                validateEmail() async {
                  
                }
                // form is valid, handle form submission here
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            }, 
            color: Colors.amber
          ),
        ],
      ),
    );
  }
  TextFormField builfConfPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => Conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == Conform_password) {
          removeError(error: kMatchPassError);
        }
        Conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
  
    decoration: const InputDecoration(
      labelText: " Confirm Password",
      hintText: "Re-enter your password ",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.lock),
    ),
  );
}



  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
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
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
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