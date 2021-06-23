import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';

import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/neumorphic_element.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/views/audio.dart';

class Player extends StatefulWidget {
  final TrackModel track;
  // final PlaylistTracksModel? playlistTrack;
  // final bool isPlaylist;
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
                      onPress: () {
                        advancedPlayer.stop();
                        Navigator.of(context).pop();
                      },
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
                      onPress: () {},
                    ),
                  ],
                ),
              ),
              NeumorphicElement(
                size: MediaQuery.of(context).size.width * .7,
                borderWidth: 5,
                image: widget.track.image,
                onPress: () {},
              ),
              SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.track.trackName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Curated by ',
                    style: TextStyle(
                      color: Colors.white54,
                      letterSpacing: 0.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
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
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Audio(
                  advancedPlayer: advancedPlayer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
