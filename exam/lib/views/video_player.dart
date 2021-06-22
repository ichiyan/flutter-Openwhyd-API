import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/neumorphic_element.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final TrackModel track;
  // const Player({Key? key}) : super(key: key);

  VideoPlayer({required this.track});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  // late AudioPlayer advancedPlayer;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.track.audio.substring(4),
      flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: true,
          loop: false,
          enableCaption: false),
    )..addListener(() {
        print(_controller.value.playerState);
      });
    super.initState();
    // print('track.audio');
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      //color: Colors.white,
      opacity: false,
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
                        // advancedPlayer.stop();
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
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.teal,
                onReady: () {
                  print('Player is ready.');
                },
              ),
              // NeumorphicElement(
              //   size: MediaQuery.of(context).size.width * .7,
              //   borderWidth: 5,

              //   image: widget.track.image,
              //   onPress: () {},
              // ),
              SizedBox(
                height: 35.0,
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
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
