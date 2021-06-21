import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/custom_widgets/playlist_tracks_item.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/models/playlist_tracks_model.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/views/home.dart';
import 'package:openwhyd_api_music_app/views/likes.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class PlaylistTracks extends StatefulWidget {
  static const String routeName = "playlist_tracks";
  //final User user;
  final int showPlaylistNum;
  const PlaylistTracks({Key? key, required this.showPlaylistNum})
      : super(key: key);

  //int getShowPlaylistNum (){return this.showPlaylistNum; }

  @override
  _PlaylistTracksState createState() => _PlaylistTracksState(showPlaylistNum);
}

class _PlaylistTracksState extends State<PlaylistTracks> {
  late Future<List<TrackModel>> futurePlaylistTracks;
  final TextEditingController textFieldController = TextEditingController();
  final int showNum;
  late var valueText;
  late var codeDialog;

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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            trackForm(context);
          },
          child: Icon(Icons.add, size: 40.0,),
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

  Future<void> trackForm (BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Playlist name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: textFieldController,
              decoration: InputDecoration(hintText: "Input name of new playlist"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white,
                ),
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('CREATE'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.teal,
                  primary: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    createPlaylist(valueText);
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }

  Future<void> createPlaylist(String value) async {
    final response = await http.post(
      Uri.parse('https://openwhyd.org/api/playlist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "followRedirects": "false",
      },
      body: jsonEncode(<String, String>{
        'action': "create",
        'name': value,
      }),
    );
  }

}