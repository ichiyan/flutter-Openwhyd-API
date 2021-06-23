import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';
import 'package:openwhyd_api_music_app/widgets/neumorphic_element.dart';

class Audio extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  //final String audioPath;
  // const Audio({Key? key, required this.advancedPlayer}) : super(key: key);
  //const Audio({Key? key, required this.advancedPlayer, required this.audioPath})
  //  : super(key: key);
  const Audio({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  // final String path =
  //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3";
  final String path =
      "https://assets.mixkit.co/music/preview/mixkit-summer-fun-13.mp3";
  bool isPlaying = true;
  bool isPaused = false;
  bool isRepeat = false;
  Color controllerIconColor = AppColors.styleColor;
  List<IconData> _icons = [
    Icons.play_arrow,
    Icons.pause,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    //this.widget.advancedPlayer.setUrl(path);
    //var yt = YoutubeExplode();
    //var manifest = yt.videos.streamsClient.getManifest('Dpp1sIL1m5Q');
    // var streamInfo = StreamManifest().audioOnly.withHighestBitrate();
    // var stream = yt.videos.streamsClient.get(streamInfo);
    // print(manifest);

    this.widget.advancedPlayer.play(path);

    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnPlay() {
    return NeumorphicElement(
      size: 80,
      child: Icon(
        isPlaying == false ? _icons[0] : _icons[1],
        color: Colors.white70,
      ),
      isActive: true,
      onPress: () {
        this.widget.advancedPlayer.play(path);
        if (isPlaying == false) {
          this.widget.advancedPlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFastRewind() {
    return NeumorphicElement(
      size: 50,
      child: Icon(
        Icons.fast_rewind,
        color: AppColors.styleColor,
      ),
      onPress: () {
        this.widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);
      },
    );
  }

  Widget btnFastForward() {
    return NeumorphicElement(
      size: 50,
      child: Icon(
        Icons.fast_forward,
        color: AppColors.styleColor,
      ),
      onPress: () {
        this.widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
      },
    );
  }

  Widget btnRepeat() {
    return NeumorphicElement(
      size: 50,
      child: Icon(
        Icons.repeat,
        color: controllerIconColor,
      ),
      isActive: false,
      onPress: () {
        if (isRepeat == false) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            controllerIconColor = AppColors.mainAccentColor;
          });
        } else if (isRepeat = true) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat = false;
            controllerIconColor = AppColors.styleColor;
            isRepeat = false;
          });
        }
      },
    );
  }

  Widget btnLoop() {
    return NeumorphicElement(
      size: 50,
      child: Icon(
        Icons.repeat,
        color: AppColors.styleColor,
      ),
      onPress: () {},
    );
  }

  Widget loadControllers() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnRepeat(),
          btnFastRewind(),
          btnPlay(),
          btnFastForward(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: AppColors.mainAccentColor,
      inactiveColor: AppColors.styleColor,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(color: AppColors.styleColor),
                ),
                Text(_duration.toString().split(".")[0],
                    style: TextStyle(color: AppColors.styleColor)),
              ],
            ),
          ),
          slider(),
          SizedBox(
            height: 25.0,
          ),
          loadControllers(),
        ],
      ),
    );
  }
}
