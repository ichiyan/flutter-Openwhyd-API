import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/mixins/validation_mixin.dart';
import 'package:openwhyd_api_music_app/widgets/custom_text_form_field.dart';
import 'package:openwhyd_api_music_app/widgets/password_field.dart';
import 'package:openwhyd_api_music_app/widgets/primary_button.dart';
import 'package:openwhyd_api_music_app/widgets/secondary_button.dart';
import 'package:openwhyd_api_music_app/widgets/forgot_password.dart';
import 'bottom_nav.dart';
import 'registration.dart';

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
  bool invalid = false;
  String? err;

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
                      // validation: validatePassword,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                      text: "Login",
                      iconData: Icons.login,
                      onPress: () {
                        if (formKey.currentState!.validate() && !invalid) {
                          final res = signIn(emailTextController.text,
                                  passwordTextController.text)
                              .then((data) {
                            print('Logging In...');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                        // user: User(
                                        //     email: emailTextController.text,
                                        //     password:
                                        //         passwordTextController.text)
                                        )));
                            invalid = false;
                            formKey.currentState!.reset();
                          }, onError: (error) {
                            err = error;
                            invalid = true;
                            print(error);
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text('Incorrect password or email'),
                            //   action: SnackBarAction(
                            //     label: 'Undo',
                            //     onPressed: () {
                            //       // Some code to undo the change.
                            //     },
                            //   ),
                            // ));
                          });
                        }
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
                        ForgotPassword(),
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
    //Navigator.pushNamed(context, Registration.routeName);
    //PLEASE DON'T CHANGE THIS CAUSE THE NAMED ROUTED HAVEN'T BEEN WORKING IN MINE
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Registration();
      }),
    );
  }
}
