// import 'dart:ffi';

// import 'package:coworking_space/components/custom_surfix_icon.dart';
import 'package:coworking_space/components/default_button.dart';
import 'package:coworking_space/components/form_error.dart';
import 'package:coworking_space/components/no_account_text.dart';
import 'package:coworking_space/screen/login_success/login_success_screen.dart';
// import 'package:coworking_space/constants.dart';
// import 'package:coworking_space/screen/login_success/login_success_screen.dart';
import 'package:coworking_space/screen/sign_in/sign_in_screen.dart';
import 'package:coworking_space/size_config.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];

  TextEditingController _oldpasswordController = new TextEditingController();
  TextEditingController _newpasswordController = new TextEditingController();
  TextEditingController _newconpasswordController = new TextEditingController();
  String email;
  String oldpassword;
  String newpassword;
  String newconpassword;
  bool _obscureText = true;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    
        return SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                 TextFormField(
                  autofocus: false,
                  obscureText: _obscureText,
                  controller: _oldpasswordController,
                  keyboardType: TextInputType.text,
                  // ignore: deprecated_member_use
                  // controller: passwordTextController,
                  onSaved: (value) => oldpassword = value,
              onChanged: (value) {
                if (value.length == 0)
                  return "Please old Enter password";
                else if (value.length >= 12)
                  return "old Password should be less then 12 char long";
                else if (value.length <= 6)
                  return "old Password should be more then 6 char long";
                else
                  return null;
              },
              validator: (value) {
                if (value.length == 0)
                  return "Please Enter old password";
                else if (value.length >= 12)
                  return "old Password should be less then 12 char long";
                else if (value.length <= 6)
                  return "old Password should be more then 6 char long";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "old Password",
                hintText: "Enter old password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                  ),
                ),
              ),
            ),
                SizedBox(height: getProportionateScreenHeight(30)),
                 TextFormField(
                  autofocus: false,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  // ignore: deprecated_member_use
                  controller: _newpasswordController,
                  onSaved: (value) => newpassword = value,
              onChanged: (value) {
                if (value.length == 0)
                  return "Please Enter New password";
                else if (value.length >= 12)
                  return "New Password should be less then 12 char long";
                else if (value.length <= 6)
                  return "New Password should be more then 6 char long";
                else
                  return null;
              },
              validator: (value) {
                if (value.length == 0)
                  return "Please Enter New password";
                else if (value.length >= 12)
                  return "New Password should be less then 12 char long";
                else if (value.length <= 6)
                  return "New Password should be more then 6 char long";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "New Password",
                hintText: "Enter New password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                  ),
                ),
              ),
            ),
             SizedBox(height: getProportionateScreenHeight(30)),

             TextFormField(
                  autofocus: false,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  // ignore: deprecated_member_use
                  controller: _newconpasswordController,
                  onSaved: (value) => newconpassword = value,
              onChanged: (value) {
                if (value.length == 0)
                  return "Please Enter New confirm password";
                else if (value.length >= 12)
                  return " New confirm Password should be less then 12 char long";
                else if (value.length <= 6)
                  return " New confirm Password should be more then 6 char long";
                else
                  return null;
              },
              validator: (value) {
                if (value.length == 0)
                  return "Please Enter New confirm password";
                else if (value.length >= 12)
                  return " New confirm Password should be less then 12 char long";
                else if (value.length <= 6)
                  return " New confirm Password should be more then 6 char long";
                else if(value != _newpasswordController.text)
                     return " confirm password must match !!";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "Confirm New Password",
                hintText: "Enter Confirm New password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                  ),
                ),
              ),
            ),
            FormError(errors: errors),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Text(" Write your email we will send code there"),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState.validate()) {
                //   // Do what you want to do

                // }
                // changepassword();
                showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Password Change Alert'),
                                content: const Text('Your password was successfully changed'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context,LoginSuccessScreen.routeName),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                }
                else {
                  setState(() {
                    // validation error
                    _autoValidate = true;
                  });
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            NoAccountText(),
          ],
      ),
    ),
        );
  }
   
   
    // Future<void> updatePassword() async {
    //     // [START update_password]
    //     FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //     String newPassword = "SOME-SECURE-PASSWORD";

    //     user.updatePassword(newPassword)
    //             .addOnCompleteListener(new OnCompleteListener<Void>() {
    //                 @Override
    //                 public void onComplete(@NonNull Task<Void> task) {
    //                     if (task.isSuccessful()) {
    //                         Log.d(TAG, "User password updated.");
    //                     }
    //                 }
    //             });
    //     // [END update_password]
    // }
}
