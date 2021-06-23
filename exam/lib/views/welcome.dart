import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/widgets/forgot_password.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_button.dart';

import '../app_style.dart';
import '../routes.dart';

class Welcome extends StatelessWidget {
  static const String routeName = "login";

  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/bg7.jpg'),
                  Positioned(
                    top: 50,
                    right: 30,
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/app_icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Openwhyd',
                          style: kTitleTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Curated tracks',
                          style: kBodyTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 450,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          GradientBtnWidget(
                              width: 208,
                              child: Text('Sign Up',
                                  style: kBtnTextStyle.copyWith(
                                    color: Colors.white,
                                  )),
                              onTap: () {
                                navigateToRegistration(context);
                              }),
                          SizedBox(height: 16),
                          GestureDetector(
                            child: Container(
                              width: 208,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: kBtnShadow,
                                borderRadius: BorderRadius.circular(kBtnRadius),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: kBtnTextStyle.copyWith(
                                  color: Colors.teal[400],
                                ),
                              ),
                            ),
                            onTap: () {
                              navigateToLogin(context);
                            },
                          ),
                          SizedBox(height: 16),
                          ForgotPassword(),
                          SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // GradientBtnWidget(
              //     width: 208,
              //     child: Text('Sign Up',
              //         style: kBtnTextStyle.copyWith(
              //           color: Colors.white,
              //         )),
              //     onTap: () {
              //       navigateToRegistration(context);
              //     }),
              // SizedBox(height: 16),
              // GestureDetector(
              //   child: Container(
              //     width: 208,
              //     height: 48,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: kBtnShadow,
              //       borderRadius: BorderRadius.circular(kBtnRadius),
              //     ),
              //     alignment: Alignment.center,
              //     child: Text(
              //       'Login',
              //       style: kBtnTextStyle.copyWith(
              //         color: Colors.tealAccent,
              //       ),
              //     ),
              //   ),
              //   onTap: () {
              //     navigateToLogin(context);
              //   },
              // ),
              // SizedBox(height: 16),
              // ForgotPassword(),
              // SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
