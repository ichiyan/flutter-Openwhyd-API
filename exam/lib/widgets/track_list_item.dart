import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrackListItem extends StatelessWidget {
  final String trackName;
  final String? userName;
  final String image;
  final String id;
  final String? like;

  TrackListItem({required this.trackName, required this.image,
    required this.id, this.like, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            height: 85.0,
            width: 85.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trackName,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  userName ?? 'unknown',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  like.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: (){
                likeTrack(context, id);
              },
              icon: Icon(
                Icons.favorite_border_rounded,
                color: like=="true"?Colors.red:Colors.white24 ,
              ),
          ),
        ],
      ),
    );
  }

  Future<void> likeTrack (BuildContext context, String id) async {
    var url = 'https://openwhyd.org/api/post?action=toggleLovePost&pId=' + id;
    final response = await http.get(Uri.parse(url));

    print(id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return showDialog(
          context: context,
          builder: (context){
            Future.delayed(Duration(seconds: 2), (){
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text("Track liked!"),
            );
          });
    } else {
      throw Exception('Failed to like track');
    }
  }

}
