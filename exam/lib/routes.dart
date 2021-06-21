import 'package:openwhyd_api_music_app/views/login.dart';
import 'package:openwhyd_api_music_app/views/registration.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
};
