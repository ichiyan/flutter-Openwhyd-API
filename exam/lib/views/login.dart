import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/app_style.dart';
import 'package:openwhyd_api_music_app/mixins/validation_mixin.dart';
import 'package:openwhyd_api_music_app/routes.dart';
import 'package:openwhyd_api_music_app/widgets/clipper.dart';
import 'package:openwhyd_api_music_app/widgets/custom_text_form_field.dart';
import 'package:openwhyd_api_music_app/widgets/password_field.dart';
import 'package:openwhyd_api_music_app/widgets/primary_button.dart';
import '../app_colors.dart';
import 'bottom_nav.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/bg4.jpg'),
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
                            'Login',
                            style: kTitleTextStyle,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your Email',
                            style: kBodyTextStyle.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomTextFormField(
                            labelText: "Email Address",
                            hintText: "Enter a valid email",
                            iconData: Icons.email,
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
                            hintText: "Enter a valid password",
                            obscureText: obscureText,
                            onTap: setPasswordVisibility,
                            textEditingController: passwordTextController,
                            validation: validatePassword,
                          ),
                          SizedBox(height: 32),
                          PrimaryButton(
                            text: "Login",
                            iconData: Icons.login,
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                final res = signIn(emailTextController.text,
                                        passwordTextController.text)
                                    .then((data) {
                                  print(data);
                                  log('Logging In...');
                                  if (data['error'] != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 2),
                                            backgroundColor: AppColors.danger,
                                            content: Row(children: [
                                              Icon(Icons.error_outline_rounded),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    data['error'],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ])));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavBar()));
                                    formKey.currentState!.reset();
                                  }
                                }).onError((error, stackTrace) {
                                  print(error);
                                  return null;
                                });
                              }
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

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
