import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/views/playlist_tracks.dart';
import 'package:openwhyd_api_music_app/views/video_player.dart';
import 'package:openwhyd_api_music_app/widgets/gradient_containers.dart';
import 'package:openwhyd_api_music_app/widgets/horizontal_playlist_item.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;
import 'package:openwhyd_api_music_app/api/openwhyd.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/views/player.dart';
import 'package:openwhyd_api_music_app/widgets/logout_button.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/widgets/track_list_item.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";
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
    futurePlaylist = fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GradientContainer(
      opacity: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        LogoutButton(),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Hi There,',
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Theme.of(context).accentColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          globals.userName,
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Your Playlists',
                      style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.styleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 0.28 * size.height,
                      width: size.width * 0.9,
                      child: FutureBuilder<List<PlaylistModel>>(
                        future: futurePlaylist,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PlaylistModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => GestureDetector(
                                child: HorizontalPlaylistItem(
                                  playlist: snapshot.data![index].playlist,
                                  image: snapshot.data![index].image,
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Popular Tracks',
                      style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.styleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 0.35 * size.height,
                      width: size.width,
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
                                        builder: (context) => VideoPlayer(
                                            track: snapshot.data![index])),
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
        ),
      ),
    );
  }

  void navigateToPlaylistTracks(BuildContext context, int num) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PlaylistTracks(
          showPlaylistNum: num,
        );
      }),
    );
  }
}
