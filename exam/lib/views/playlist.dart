import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/custom_widgets/playlist_item.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/models/user_model.dart';
import 'package:openwhyd_api_music_app/views/Registration.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Playlist extends StatefulWidget {
  static const String routeName = "Playlist";
  final User user;

  const Playlist({Key? key, required this.user}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  late Future<List<PlaylistModel>> futurePlaylist;
  int _selectedIndex = 2;

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
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            _onItemTapped(index);
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text("Home"),
              selectedColor: Theme.of(context).accentColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              title: Text("Likes"),
              selectedColor: Theme.of(context).accentColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.queue_music_rounded),
              title: Text("Playlist"),
              selectedColor: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}