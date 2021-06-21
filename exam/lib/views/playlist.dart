import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/custom_widgets/playlist_item.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/views/playlist_tracks.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';

class Playlist extends StatefulWidget {
  static const String routeName = "Playlist";
  // final User user;
  const Playlist({Key? key}) : super(key: key);

  //const Playlist({Key? key, required this.user}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late Future<List<PlaylistModel>> futurePlaylist;

  @override
  void initState() {
    super.initState();
    futurePlaylist = fetchPlaylist();
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Playlist",
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
                  child: FutureBuilder<List<PlaylistModel>>(
                    future: futurePlaylist,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PlaylistModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => GestureDetector(
                            child: PlaylistItem(
                              playlist: snapshot.data![index].playlist,
                              image: snapshot.data![index].image,
                              trackNum: snapshot.data![index].trackNum,
                            ),
                            onTap: () {
                              navigateToPlaylistTracks(context, index);
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

  void navigateToPlaylistTracks(BuildContext context, int num) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaylistTracks(showPlaylistNum: num,);
      }),
    );
  }