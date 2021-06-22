import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/views/login.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      hintColor: Colors.grey[400],
    ),
    home: Login(),
  ));
}
