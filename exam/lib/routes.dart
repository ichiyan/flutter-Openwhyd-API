import 'package:openwhyd_api_music_app/views/Dashboard.dart';
import 'package:openwhyd_api_music_app/views/Login.dart';
import 'package:openwhyd_api_music_app/views/Registration.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/views/home.dart';


final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
  Dashboard.routeName: (BuildContext context) => Dashboard(),
  Home.routeName: (BuildContext context) => Home(),
};
