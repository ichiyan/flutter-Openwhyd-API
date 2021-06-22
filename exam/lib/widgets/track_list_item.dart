import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdriver/sync_io.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../globals.dart';

class TrackListItem extends StatelessWidget {
  final String trackName;
  final String? userName;
  final String image;
  final String id;
  final String? like;

  TrackListItem(
      {required this.trackName,
      required this.image,
      required this.id,
      this.like,
      this.userName});

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
        },
        icon: Icon(
          like == "true"
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: like == "true" ? Colors.redAccent : Colors.white24,
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
        "Cookie": "whydSid=s%3A3PID3DkFHDT2AOhxbEfmHY3oHRyVHEGl.6RmUyEO8RrPcbAJ1Sn0AuIjm2oPMn0B9%2Brj%2F8NZz0mA",
      },
    );

    print(response.statusCode);
    print(response.request);
    print(response.body);

    final jsonData = jsonDecode(response.body);
    print(jsonData["loved"]);

    if (response.statusCode == 200) {
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
