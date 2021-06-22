import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/mixins/validation_mixin.dart';
import 'package:openwhyd_api_music_app/widgets/clipper.dart';
import 'package:openwhyd_api_music_app/widgets/custom_text_form_field.dart';
import 'package:openwhyd_api_music_app/widgets/password_field.dart';
import 'package:openwhyd_api_music_app/widgets/primary_button.dart';
import '../app_colors.dart';
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
    // return SafeArea(
    //   child: Scaffold(
    //     body: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20.0),
    //       alignment: Alignment.topCenter,
    //       child: Center(
    //         child: SingleChildScrollView(
    //           child: Form(
    //             key: formKey,
    //             child: Column(
    //               children: [
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 CustomTextFormField(
    //                   labelText: "Email Address",
    //                   hintText: "Enter a valid email",
    //                   iconData: Icons.email,
    //                   textEditingController: emailTextController,
    //                   textInputType: TextInputType.emailAddress,
    //                   validation: validateEmail,
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 PasswordField(
    //                   labelText: "Password",
    //                   hintText: "Enter a valid password",
    //                   obscureText: obscureText,
    //                   onTap: setPasswordVisibility,
    //                   textEditingController: passwordTextController,
    //                   // validation: validatePassword,
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 PrimaryButton(
    //                   text: "Login",
    //                   iconData: Icons.login,
    //                   onPress: () {
    //                     if (formKey.currentState!.validate() && !invalid) {
    //                       final res = signIn(emailTextController.text,
    //                               passwordTextController.text)
    //                           .then((data) {
    //                         print('Logging In...');
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => BottomNavBar(
    //                                     // user: User(
    //                                     //     email: emailTextController.text,
    //                                     //     password:
    //                                     //         passwordTextController.text)
    //                                     )));
    //                         invalid = false;
    //                         formKey.currentState!.reset();
    //                       }, onError: (error) {
    //                         err = error;
    //                         invalid = true;
    //                         print(error);
    //                         // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                         //   content: Text('Incorrect password or email'),
    //                         //   action: SnackBarAction(
    //                         //     label: 'Undo',
    //                         //     onPressed: () {
    //                         //       // Some code to undo the change.
    //                         //     },
    //                         //   ),
    //                         // ));
    //                       });
    //                     }
    //                   },
    //                 ),
    //                 SizedBox(
    //                   height: 20.0,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     SecondaryButton(
    //                         text: "New User? Register",
    //                         onPress: () {
    //                           navigateToRegistration(context);
    //                         }),
    //                     ForgotPassword(),
    //                   ],
    //                 ),
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
            // Image.asset('login_bg.jpeg'),
            Image.asset('assets/login_bg.jpg'),
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       // fit: BoxFit.cover,
            //       image: AssetImage("assets/bg_login_header.png"),
            //       // image: AssetImage("assets/login_bg.jpg"),
            //     ),
            //   ),
            // ),
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
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.kTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your Email',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.kTextColor,
                              fontWeight: FontWeight.w500,
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
                          // LoginInput(
                          //   hintText: 'Email',
                          //   prefixIcon: 'assets/icons/icon_email.png',
                          // ),
                          SizedBox(height: 16),
                          Text(
                            'Your Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.kTextColor,
                              fontWeight: FontWeight.w500,
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
                          // LoginInput(
                          //   hintText: 'Password',
                          //   prefixIcon: 'assets/icons/icon_pwd.png',
                          //   obscureText: true,
                          // ),
                          SizedBox(height: 32),
                          PrimaryButton(
                            text: "Login",
                            iconData: Icons.login,
                            onPress: () {
                              if (formKey.currentState!.validate() &&
                                  !invalid) {
                                final res = signIn(emailTextController.text,
                                        passwordTextController.text)
                                    .then((data) {
                                  print('Logging In...');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar()));
                                  invalid = false;
                                  formKey.currentState!.reset();
                                }, onError: (error) {
                                  err = error;
                                  invalid = true;
                                  print(error);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text('Incorrect password or email'),
                                    // action: SnackBarAction(
                                    //   label: 'Undo',
                                    //   onPressed: () {
                                    //     // Some code to undo the change.
                                    //   },
                                    // ),
                                  ));
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
            // Positioned(
            //   top: 64,
            //   left: 28,
            //   child: BackIcon(),
            // )
          ],
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
