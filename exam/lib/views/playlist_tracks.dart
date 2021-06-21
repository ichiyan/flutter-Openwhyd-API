import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/custom_widgets/playlist_tracks_item.dart';
import 'package:openwhyd_api_music_app/models/playlist_tracks_model.dart';
import 'package:openwhyd_api_music_app/views/home.dart';
import 'package:openwhyd_api_music_app/views/likes.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';


class PlaylistTracks extends StatefulWidget {
  static const String routeName = "playlist_tracks";
  //final User user;
  final int showPlaylistNum;
  const PlaylistTracks({Key? key, required this.showPlaylistNum}) : super(key: key);

  //int getShowPlaylistNum (){return this.showPlaylistNum; }

  @override
  _PlaylistTracksState createState() => _PlaylistTracksState(showPlaylistNum);
}

class _PlaylistTracksState extends State<PlaylistTracks> {
  late Future<List<PlaylistTracksModel>> futurePlaylistTracks;
  final int showNum;

  _PlaylistTracksState(this.showNum);

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
                      child: Text(
                        "Playlist Tracks",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    LogoutButton(),
                  ],
                ),
                Expanded(
                  child: FutureBuilder<List<PlaylistTracksModel>>(
                    future: futurePlaylistTracks,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PlaylistTracksModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => GestureDetector(
                            child: PlaylistTracksItem(
                              songTitle: snapshot.data![index].songTitle,
                              image: snapshot.data![index].image,
                              name: snapshot.data![index].name,
                              playlistName: snapshot.data![index].playlistName,
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           Player(track: snapshot.data![index])),
                              // );
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

  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Home();
      }),
    );
  }

  void navigateToLike(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Likes();
      }),
    );
  }
}