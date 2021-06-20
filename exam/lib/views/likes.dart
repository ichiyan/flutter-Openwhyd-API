import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/models/user_model.dart';
import 'package:openwhyd_api_music_app/views/home.dart';
import 'package:openwhyd_api_music_app/views/playlist.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';

class Likes extends StatefulWidget {
  static const String routeName = "Likes";

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  int _selectedIndex = 1;

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
                    "Likes",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Text("text"),
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
    if(index == 0){
      navigateToHome(context);
    }
    if(index == 2){
      navigateToPlaylist(context);
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Home(user: User(email: "annethere_paulo@yahoo.com", password: "7300227paulo"));
      }),
    );
  }

  void navigateToPlaylist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Playlist(user: User(email: "annethere_paulo@yahoo.com", password: "7300227paulo"));
      }),);
  }
}