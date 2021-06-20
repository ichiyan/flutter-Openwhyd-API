import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/models/user_model.dart';
import 'package:openwhyd_api_music_app/views/likes.dart';
import 'package:openwhyd_api_music_app/views/playlist.dart';
import 'package:openwhyd_api_music_app/views/registration.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:openwhyd_api_music_app/custom_widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/custom_widgets/track_list_item.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<TrackModel>> futureTrack;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureTrack = fetchHotTracks();
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
                        "Hot Tracks",
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
                            child: TrackListItem(
                              trackName: snapshot.data![index].trackName,
                              image: snapshot.data![index].image,
                              userName: snapshot.data![index].userName,
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
    if(index == 1){
      navigateToLike(context);
    }
    if(index == 2){
      navigateToPlaylist(context);
    }
  }

  void navigateToPlaylist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
      return Playlist(user: User(email: "annethere_paulo@yahoo.com", password: "7300227paulo"));
    }),);
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