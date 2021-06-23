import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openwhyd_api_music_app/views/welcome.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Paint.enableDithering = true;
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      hintColor: Colors.grey[400],
    ),
    home: Welcome(),
  ));
}
