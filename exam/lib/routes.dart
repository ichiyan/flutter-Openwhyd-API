import 'package:openwhyd_api_music_app/views/login.dart';
import 'package:openwhyd_api_music_app/views/registration.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/views/welcome.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
  Welcome.routeName: (BuildContext context) => Welcome(),
};

void navigateToWelcome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return Welcome();
    }),
  );
}

void navigateToLogin(BuildContext context) {
  //Navigator.pushNamed(context, Login.routeName);
  //PLEASE DON'T CHANGE THIS CAUSE THE NAMED ROUTED HAVEN'T BEEN WORKING IN MINE
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return Login();
    }),
  );
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
