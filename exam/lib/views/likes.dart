import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/playlist_tracks_item.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';

class Likes extends StatefulWidget {
  static const String routeName = "likes";
  const Likes({Key? key}) : super(key: key);

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  late Future<List<TrackModel>> futureTrack;

  @override
  void initState() {
    super.initState();
    futureTrack = fetchLikedTracks();
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
                        "Liked Tracks",
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
                  child: FutureBuilder<List<TrackModel>>(
                    future: futureTrack,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Player(track: snapshot.data![index])),
                              );
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
