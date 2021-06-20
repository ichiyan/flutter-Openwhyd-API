import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/models/user_model.dart';
import 'package:openwhyd_api_music_app/views/login.dart';
import 'package:openwhyd_api_music_app/views/playlist.dart';

import 'views/home.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    home:Login(),
    //Playlist(user: User(email: "annethere_paulo@yahoo.com", password: "7300227paulo")),
  ));
}
