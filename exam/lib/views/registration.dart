import 'dart:convert';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/mixins/validation_mixin.dart';
import 'package:openwhyd_api_music_app/models/user_model.dart';
import 'package:openwhyd_api_music_app/routes.dart';
import 'package:openwhyd_api_music_app/widgets/clipper.dart';
import 'package:openwhyd_api_music_app/widgets/custom_text_form_field.dart';
import 'package:openwhyd_api_music_app/widgets/password_field.dart';
import 'package:openwhyd_api_music_app/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

import '../app_colors.dart';
import '../app_style.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  static const String routeName = "registration";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with ValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  // String _message = 'Log in/out by pressing the buttons below.';
  bool obscureText = true;

  // Future<Null> _login() async {
  //   final FacebookLoginResult result =
  //   await facebookSignIn.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       _showMessage('''
  //        Logged in!
  //
  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       _showMessage('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       _showMessage('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       break;
  //   }
  // }
  //
  // Future<Null> _logOut() async {
  //   await facebookSignIn.logOut();
  //   _showMessage('Logged out.');
  // }
  //
  // void _showMessage(String message) {
  //   setState(() {
  //     _message = message;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Registration"),
    //     ),
    //     body: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20.0),
    //       child: Center(
    //         child: SingleChildScrollView(
    //           child: Form(
    //             key: formKey,
    //             child: Column(
    //               children: <Widget>[
    //                 CustomTextFormField(
    //                   labelText: "Full Name",
    //                   hintText: "Enter full name",
    //                   iconData: Icons.person,
    //                   textEditingController: fullNameTextController,
    //                   textInputType: TextInputType.name,
    //                   validation: validateName,
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 CustomTextFormField(
    //                   labelText: "Email Address",
    //                   hintText: "Enter a valid email",
    //                   iconData: Icons.mail_rounded,
    //                   textEditingController: emailTextController,
    //                   textInputType: TextInputType.emailAddress,
    //                   validation: validateEmail,
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 PasswordField(
    //                   labelText: "Password",
    //                   hintText: "Enter password",
    //                   textEditingController: passwordTextController,
    //                   obscureText: obscureText,
    //                   onTap: setPasswordVisibility,
    //                   validation: validatePassword,
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 PrimaryButton(
    //                   text: "Sign up",
    //                   iconData: Icons.app_registration,
    //                   onPress: () {
    //                     print('done typing');
    //                     signUp(
    //                             context,
    //                             fullNameTextController.text,
    //                             emailTextController.text,
    //                             passwordTextController.text)
    //                         .then((value) {
    //                       print('pushing');
    //                     }).catchError((error) {
    //                       print(error);
    //                     });
    //                   },
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     SecondaryButton(
    //                       text: "Already have an account? Login",
    //                       onPress: () {
    //                         //navigateToLogin(context);
    //                         //PLEASE DON'T CHANGE THIS CAUSE THE NAMED ROUTED HAVEN'T BEEN WORKING IN MINE
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(builder: (context) {
    //                             return Login();
    //                           }),
    //                         );
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //                 // Text(_message),
    //                 // ElevatedButton(
    //                 //     onPressed: _login,
    //                 //     child: Text("Log in"),
    //                 // ),
    //                 // ElevatedButton(
    //                 //   onPressed: _logOut,
    //                 //   child: Text("Logout"),
    //                 //),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/bg1.jpg'),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 320),
                  ClipPath(
                    clipper: LoginClipper(),
                    child: Container(
                      color: Colors.white,
                      width: double.maxFinite,
                      padding: EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 86),
                          Text(
                            'Sign Up',
                            style: kTitleTextStyle,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your Full Name',
                            style: kBodyTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomTextFormField(
                            labelText: "Full Name",
                            hintText: "Enter full name",
                            iconData: Icons.person,
                            textEditingController: fullNameTextController,
                            textInputType: TextInputType.name,
                            validation: validateName,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your Email',
                            style: kBodyTextStyle
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                )
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          SizedBox(height: 5),
                          CustomTextFormField(
                            labelText: "Email Address",
                            hintText: "Enter a valid email",
                            iconData: Icons.mail_rounded,
                            textEditingController: emailTextController,
                            textInputType: TextInputType.emailAddress,
                            validation: validateEmail,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.kTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          PasswordField(
                            labelText: "Password",
                            hintText: "Enter password",
                            textEditingController: passwordTextController,
                            obscureText: obscureText,
                            onTap: setPasswordVisibility,
                            validation: validatePassword,
                          ),
                          SizedBox(height: 32),
                          PrimaryButton(
                            text: "Sign up",
                            iconData: Icons.app_registration,
                            onPress: () {
                              print('done typing');
                              signUp(
                                      context,
                                      fullNameTextController.text,
                                      emailTextController.text,
                                      passwordTextController.text)
                                  .then((value) {
                                print('pushing');
                              }).catchError((error) {
                                print(error);
                              });
                            },
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 64,
                left: 28,
                child: GestureDetector(
                  onTap: () {
                    navigateToWelcome(context);
                  },
                  child: Container(
                    width: kIconBoxSize,
                    height: kIconBoxSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icon_back.png',
                      width: kIconSize,
                      height: kIconSize,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

//not working

  Future<void> signUp(BuildContext context, name, email, password) async {
    if (formKey.currentState!.validate()) {
      print("Valid Inputs");
      print(password);
      password = crypto.md5.convert(utf8.encode(password)).toString();
      print(password);
      print("Registering...");
      Future<User> user = createUser(name, email, password);
      user.then((data) {
        print(data.name);
      });

      Navigator.pushReplacementNamed(context, Login.routeName);
    } else {
      print("Invalid");
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, Login.routeName);
  }
}

Future<User> createUser(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse('https://openwhyd.org/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "followRedirects": "false",
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
    }),
  );

  print(response.request);
  if (response.statusCode == 201) {
    print(response.statusCode);
    return User.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 302) {
    print(response.statusCode);
    final res = await http.get(
        Uri.parse('https://openwhyd.org/${response.headers["location"]}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        });

    print(res.request);
    print(res.statusCode);
    print(res.headers["location"]);
    print(res.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  } else {
    throw Exception('Failed to create user.');
  }
}
