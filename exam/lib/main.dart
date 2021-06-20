import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/views/player.dart';

import 'views/home.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    home: Home(),
  ));
}
