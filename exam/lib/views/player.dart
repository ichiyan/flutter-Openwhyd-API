import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';

import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/custom_widgets/neumorphic_element.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';

class Player extends StatefulWidget {
  final TrackModel track;
  // const Player({Key? key}) : super(key: key);

  Player({required this.track});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      //color: Colors.white,
      opacity: true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   toolbarHeight: 40.0,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   title: Text(
          //     "Playing Now",
          //     style: TextStyle(
          //       color: Colors.grey,
          //     ),
          //   ),
          //   centerTitle: true,
          //   leading: IconButton(
          //     icon: Icon(Icons.expand_more_rounded),
          //     onPressed: () {},
          //   ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NeumorphicElement(
                      size: 50,
                      child: Icon(
                        Icons.expand_more_rounded,
                        color: AppColors.styleColor,
                      ),
                    ),
                    Text(
                      "PLAYING NOW",
                      style: TextStyle(
                        color: AppColors.styleColor,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    NeumorphicElement(
                      size: 50,
                      child: Icon(
                        Icons.menu,
                        color: AppColors.styleColor,
                      ),
                    ),
                  ],
                ),
              ),
              NeumorphicElement(
                size: MediaQuery.of(context).size.width * .7,
                borderWidth: 5,
                image: widget.track.image,
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                widget.track.trackName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 0.5,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.track.userName ?? 'unknown',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  letterSpacing: 0.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
