import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/widgets/playlist_item.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/views/playlist_tracks.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;

import 'bottom_nav.dart';

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
  final TextEditingController textFieldController = TextEditingController();
  late var valueText;
  late var codeDialog;

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            playlistForm(context);
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
                              navigateToPlaylistTracks(context, index,
                                  snapshot.data![index].playlist);
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

  void navigateToPlaylistTracks(BuildContext context, int num, String plName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaylistTracks(showPlaylistNum: num, plName: plName);
      }),
    );
  }

  Future<void> playlistForm(BuildContext context) async {
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
              decoration:
                  InputDecoration(hintText: "Input name of new playlist"),
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
                    print(valueText);
                    createPlaylist(valueText);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text(
                                  "Playlist created!",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        });
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
        "Cookie": globals.cookieChange[0],
        'Content-Type': 'application/json; charset=utf-8',
        "Accept": "*/*",
      },
      body: jsonEncode(<String, String>{
        'action': "create",
        'name': value,
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print("Success!");
      //Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return BottomNavBar();
        }),
      );
    } else {
      throw Exception('Failed to create playlist');
    }
  }
} //build

