import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';
import 'package:openwhyd_api_music_app/views/playlist.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'home.dart';
import 'likes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  List<Widget> tabs = <Widget>[
    Home(),
    Likes(),
    Playlist(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _selectedIndex = index;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: tabs[_selectedIndex],
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
    );
  }
}
