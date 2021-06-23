import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/app_colors.dart';
// import 'package:webdriver/sync_io.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;
import 'package:openwhyd_api_music_app/views/bottom_nav.dart';

// ignore: must_be_immutable
class TrackListItem extends StatelessWidget {
  final String trackName;
  final String? userName;
  final String image;
  final String id;
  final bool heartColor;

  TrackListItem({
    required this.trackName,
    required this.image,
    required this.id,
    this.userName,
    required this.heartColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        trackName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      subtitle: Text(
        userName ?? 'Unknown',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      leading: Container(
        height: 90.0,
        width: 90.0,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          likeTrack(context, id);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BottomNavBar();
            }),
          );
        },
        icon: Icon(
          heartColor ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: heartColor ? Colors.redAccent : Colors.white24,
          size: 22,
        ),
      ),
    );
  }

  Future<void> likeTrack(BuildContext context, String id) async {
    var url = 'https://openwhyd.org/api/post?action=toggleLovePost&pId=' + id;
    print(id);
    // Cookies? ex;
    // List<Cookie> ret;
    // chip = ex!.getCookie("whydSid");
    // print(chip);

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        //"Accept" : "*/*",
        "Cookie": globals.cookieChange[0],
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData["loved"] == true) {
        // return showDialog(
        //     context: context,
        //     builder: (context) {
        //       Future.delayed(Duration(seconds: 1), () {
        //         Navigator.of(context).pop(true);
        //       });
        //       return AlertDialog(
        //         title: Text(
        //           "Track liked!",
        //           textAlign: TextAlign.center,
        //         ),
        //       );
        //     });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.success,
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon(Icons.check),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Track liked!',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ])));
      } else {
        // return showDialog(
        //     context: context,
        //     builder: (context) {
        //       Future.delayed(Duration(seconds: 1), () {
        //         Navigator.of(context).pop(true);
        //       });
        //       return AlertDialog(
        //         title: Text(
        //           "Removed like from track :(",
        //           textAlign: TextAlign.center,
        //         ),
        //       );
        //     });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: AppColors.danger,
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Icon(Icons.),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Track unliked :(',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ])));
      }
    } else {
      throw Exception('Failed to like track');
    }
  }
}
