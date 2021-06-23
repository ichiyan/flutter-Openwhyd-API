import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/views/video_player.dart';
import 'package:openwhyd_api_music_app/widgets/full_screen_dialog.dart';
import 'package:openwhyd_api_music_app/widgets/playlist_tracks_item.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaylistTracks extends StatefulWidget {
  static const String routeName = "playlist_tracks";
  //final User user;
  final int showPlaylistNum;
  final String plName;
  const PlaylistTracks(
      {Key? key, required this.showPlaylistNum, required this.plName})
      : super(key: key);

  //int getShowPlaylistNum (){return this.showPlaylistNum; }

  @override
  _PlaylistTracksState createState() =>
      _PlaylistTracksState(showPlaylistNum, plName);
}

class _PlaylistTracksState extends State<PlaylistTracks> {
  late Future<List<TrackModel>> futurePlaylistTracks;
  final TextEditingController textFieldController = TextEditingController();
  final int showNum;
  final String plName;
  late var valueText;
  late var codeDialog;

  _PlaylistTracksState(this.showNum, this.plName);

  @override
  void initState() {
    super.initState();
    futurePlaylistTracks = fetchPlaylistTracks(showNum);
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      opacity: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => FullScreenDialog(
                  numPL: this.showNum,
                  plName: plName,
                ),
                fullscreenDialog: true,
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            plName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            "playlist tracks",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LogoutButton(),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<TrackModel>>(
                    future: futurePlaylistTracks,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TrackModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => GestureDetector(
                            child: PlaylistTracksItem(
                              songTitle: snapshot.data![index].trackName,
                              image: snapshot.data![index].image,
                              name: snapshot.data![index].userName,
                              playlistName: snapshot.data![index].playlistName,
                            ),
                            onTap: () {
                              if (YoutubePlayer.convertUrlToId(
                                      snapshot.data![index].audio) !=
                                  null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayer(
                                          track: snapshot.data![index])),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Player(track: snapshot.data![index])),
                                );
                              }
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
