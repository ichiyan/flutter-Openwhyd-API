import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/mixins/ValidationMixin.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:openwhyd_api_music_app/views/home.dart';
import 'package:openwhyd_api_music_app/widgets/CustomTextFormField.dart';
import 'package:openwhyd_api_music_app/widgets/PasswordField.dart';
import 'package:openwhyd_api_music_app/widgets/PrimaryButton.dart';
import 'package:openwhyd_api_music_app/widgets/SecondaryButton.dart';

import 'Registration.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          alignment: Alignment.topCenter,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      labelText: "Email Address",
                      hintText: "Enter a valid email",
                      iconData: Icons.email,
                      textEditingController: emailTextController,
                      textInputType: TextInputType.emailAddress,
                      validation: validateEmail,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      labelText: "Password",
                      hintText: "Enter a valid password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      textEditingController: passwordTextController,
                      validation: validatePassword,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                      text: "Login",
                      iconData: Icons.login,
                      onPress: () {
                        // Navigator.pushReplacementNamed(context, Home.routeName, arguments: User(email: emailTextController.text, password: passwordTextController.text));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Home(user: User(email: emailTextController.text, password: passwordTextController.text))
                        //     ));

                        final res = signIn(emailTextController.text,
                            passwordTextController.text)
                            .then((data) {
                              print('Loggin In...');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(user: User(email: emailTextController.text, password: passwordTextController.text))
                                  ));
                            }, onError: (error) {
                              print("Error here");
                              print(error);
                            });

                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondaryButton(
                            text: "New User? Register",
                            onPress: () {
                              navigateToRegistration(context);
                            }),
                        SecondaryButton(
                            text: "Forgot Password?", onPress: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> signIn(String email, String password) async {
    password = crypto.md5.convert(utf8.encode(password)).toString();
    final res = await http.get(Uri.parse('https://openwhyd.org/login?action=login&ajax=true&email=$email&md5=$password'));

    print(res.statusCode);
    print(res.request);
    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      // return User.fromJson(jsonDecode(res.body));
      // return type = dynamic; returning a json object from res.body due to loggin in succesfully return only a redirection url;
      print(jsonData);
      if (jsonData["redirect"] != null) {
        return jsonData;
      }
      throw Exception(jsonData["error"]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }
    print('4');
  }

  // void login() {
  //   if (formKey.currentState!.validate()) {
  //     print("Valid Inputs");
  //     Navigator.pushReplacementNamed(context, Dashboard.routeName);
  //   } else {
  //     print("Invalid");
  //   }
  // }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void navigateToRegistration(BuildContext context) {
    Navigator.pushNamed(context, Registration.routeName);
  }
}
