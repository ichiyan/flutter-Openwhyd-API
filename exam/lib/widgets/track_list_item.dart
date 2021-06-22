import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:webdriver/sync_io.dart';
// import 'package:cookie_jar/cookie_jar.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;
import 'package:openwhyd_api_music_app/views/home.dart';

// ignore: must_be_immutable
class TrackListItem extends StatelessWidget {
  final String trackName;
  final String? userName;
  final String image;
  final String id;
  final bool heartColor;

  TrackListItem(
      {required this.trackName,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Home();
            }),
          );
        },
        icon: Icon(
          heartColor
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: heartColor? Colors.redAccent : Colors.white24,
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

      if(jsonData["loved"] == true){
        return showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Text(
                  "Track liked!",
                  textAlign: TextAlign.center,
                ),
              );
            });
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Text(
                  "Removed ike from track :(",
                  textAlign: TextAlign.center,
                ),
              );
            });
      }
    } else {
      throw Exception('Failed to like track');
    }
  }
}
