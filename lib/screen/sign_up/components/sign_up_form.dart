// import 'package:coworking_space/screen/login_success/login_success_screen.dart';
// import 'package:coworking_space/constants.dart';
import 'package:coworking_space/screen/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:coworking_space/components/custom_surfix_icon.dart';
import 'package:coworking_space/components/default_button.dart';
import 'package:coworking_space/components/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController passwordTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  // final emailTextController = TextEditingController();
  // final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  final firstnameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final phonenumberTextController = TextEditingController();
  final addressTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email;
  String password;
  // ignore: non_constant_identifier_names
  String Confirmpassword;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  bool _autoValidate = false;
  bool _obscureText = true;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // ignore: deprecated_member_use
      autovalidate: _autoValidate,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
            controller: firstnameTextController,
            validator: (String value) {
              // ignore: unrelated_type_equality_checks
              if (value == null || value.isEmpty) {
                return 'Please Enter First Name';
              }
              return null;
            },
            onSaved: (value) => firstName = value,
            onChanged: (value)  async {
              if (value == null || value.isEmpty) {
                return 'Please Enter First Name';
              }
              return null;
              // _avalueNotifier.value = value;
            },
            
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your Last name",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
            controller: lastnameTextController,
            validator: (String value) {
              // ignore: unrelated_type_equality_checks
              if (value == null || value.isEmpty) {
                return 'Please Enter Last Name';
              }
              return null;
            },
            onSaved: (value) => lastName = value,
            // onChanged: (value) {
            //   if (value.isNotEmpty) {
            //     removeError(error: kNamelNullError);
            //   }
            //   // return null;
            //   firstName = value;
            // },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            controller: emailTextController,
            onSaved: (value) => email = value,
            onChanged: (value) {
              if (value.length == 0)
                return "Please Enter Email";
              else if (!value.contains("@"))
                return "Please Enter valid Email";
              else
                return null;
            },
            validator: (String value) {
              if (value.length == 0)
                return "Please Enter Email";
              else if (!value.contains("@"))
                return "Please Enter valid Email \nEmail contain @gmail.com or @yahoo.com";
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            autofocus: false,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            // ignore: deprecated_member_use
            controller: passwordTextController,
            onSaved: (value) => password = value,
            onChanged: (value) {
              if (value.length == 0)
                return "Please Enter password";
              else if (value.length >= 12)
                return "Password should be less then 12 char long";
              else if (value.length <= 6)
                return "Password should be more then 6 char long";
              else
                return null;
            },
            validator: (value) {
              if (value.length == 0)
                return "Please Enter password";
              else if (value.length >= 12)
                return "Password should be less then 12 char long";
              else if (value.length <= 6)
                return "Password should be more then 6 char long";
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
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
          // buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            autofocus: false,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            // ignore: deprecated_member_use
            controller: confirmpasswordTextController,
            onSaved: (value) => password = value,

            onChanged: (String value) {
              if (value.length == 0)
                return "Please Enter Confirm password";
              else if (value.length >= 12)
                return "Password should be less then 12 char long";
              else if (value.length <= 6)
                return "Password should be more then 6 char long";
              else
                return null;
            },
            validator: (String value) {
              if (value.length == 0)
                return "Please Enter  Confirm password";
              else if (value.length >= 12)
                return "Password should be less then 12 char long";
              else if (value.length <= 6)
                return "Password should be more then 6 char long";
              else if(value != passwordTextController.text)
                return "Confirm password must match with password";
              else
                return null;
            },
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Enter your Confirm password",
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
          // buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: phonenumberTextController,
            onSaved: (value) => phoneNumber = value,
            onChanged: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Phone Number';
              }
              return null;
            },
            validator: (String value) {
              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = new RegExp(patttern);
              if (value.length == 0) {
                return 'Please Enter mobile number';
              } else if (!regExp.hasMatch(value)) {
                return 'Please Enter valid mobile number';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          // buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          TextFormField(
            onSaved: (value) => address = value,
            controller: addressTextController,
            validator: (String value) {
              if (value.length == 0)
                return "Please Enter Address";
             
              else if (value.length <= 4)
                return "Please Enter valid Address";
                else
              return null;
            },
            // onChanged: (value) {
            //   if (value.isNotEmpty) {
            //     removeError(error: kAddressNullError);
            //   }
            //   // return null;
            //   address = value;
            // },
            decoration: InputDecoration(
              labelText: "Address",
              hintText: "Enter your phone address",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          // buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
              text: "Register",
              press: () async {
                // - addddatabase to firestore but not add email id

                if (_formKey.currentState.validate()) {
                  //_formKey.currentState.save();
                  // _firestore.collection('userdetails').add({
                  //   'email': email,
                  //   'password': password,
                  //   'confirm password': Confirmpassword,
                  //   'firstname': firstName,
                  //   'lastname': lastName,
                  //   'phone number': phoneNumber,
                  //   'address': address,
                  //   // 'sender': loggedInUser.email,
                  // });
                  Firestore.instance.collection('userdetails').add({
                    'email': emailTextController.text,
                    'password': passwordTextController.text,
                    'confirm password': confirmpasswordTextController.text,
                    'firstname': firstnameTextController.text,
                    'lastname': lastnameTextController.text,
                    'phone number': phonenumberTextController.text,
                    'address': addressTextController.text,
                    'favplaces':FieldValue.arrayUnion([])
                    // 'sender': loggedInUser.email,
                  }).then((element) async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('current_login_user', element.documentID);
                      prefs.setString('current_login_user_email', emailTextController.text);
                      prefs.setString('current_login_user_phonenumber', phonenumberTextController.text);
                      prefs.setString('current_login_user_name', firstnameTextController.text +" "+ lastnameTextController.text);
                  });
                  print("Email $email");
                  print("Password $password");
                  Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } else {
                  setState(() {
                    // validation error
                    _autoValidate = true;
                  });
                }

                //----------------------------------------------------------------------------------
                // real login -  add all details to firestore but don't work now'

                  //  if (_formKey.currentState.validate()) {
                //                     // createUser();
                //                     dynamic result = await _auth.createNewUser(
                //                        firstnameTextController.text,
                //                        lastnameTextController.text,
                //                         emailTextController..text,
                //                         phonenumberTextController.text,
                //                         passwordTextController.text,
                //                         confirmpasswordTextController.text,
                //                        addressTextController.text
                //                         );
                //                     //  Navigator.pushNamed(context, '/dashboard');
                //                     if (result == null) {
                //                       print('Insert details error');
                //                     } else {
                //                       print(result.toString());
                //                       firstnameTextController.clear();
                //                       lastnameTextController.clear();
                //                       emailTextController.clear();
                //                       phonenumberTextController.clear();
                //                       passwordTextController.clear();
                //                       confirmpasswordTextController.clear();
                //                       addressTextController.clear();
                //                     }
                //                   }
              //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              // }
              }
              // },
              ),
        ],
      ),
    );
  }
}

// TextFormField buildConformPassFormField() {
//   return TextFormField(
//     obscureText: true,
//     // onSaved: (newValue) => conform_password = newValue,
//     onChanged: (value) {
//       if (value.isNotEmpty) {
//         removeError(error: kPassNullError);
//       } else if (value.isNotEmpty && password == Confirmpassword) {
//         removeError(error: kMatchPassError);
//       }
//       Confirmpassword = value;
//     },
//     validator: (value) {
//       if (value.isEmpty) {
//         addError(error: kPassNullError);
//         return "";
//       } else if ((password != value)) {
//         addError(error: kMatchPassError);
//         return "";
//       }
//       return null;
//     },
//     decoration: InputDecoration(
//       labelText: "Confirm Password",
//       hintText: "Re-enter your password",
//       // If  you are using latest version of flutter then lable text and hint text shown like this
//       // if you r using flutter less then 1.20.* then maybe this is not working properly
//       floatingLabelBehavior: FloatingLabelBehavior.always,
//       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//     ),
//   );
// }
