import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/track_list_item.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
  //final User user;
  const Home({Key? key}) : super(key: key);
  // const Home({
  //   Key? key,
  //   required this.user,
  // }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<TrackModel>> futureTrack;
  late Future<List<PlaylistModel>> futurePlaylist;
  // PageController pageController = PageController(initialPage: 0);
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     WidgetsBinding.instance!.addPostFrameCallback((_) {
  //       if (pageController.hasClients) {
  //         pageController.animateToPage(index,
  //             duration: Duration(milliseconds: 400), curve: Curves.ease);
  //       }
  //     });
  //   });
  // }

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
                              id: snapshot.data![index].id,
                              like: snapshot.data![index].like,
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
