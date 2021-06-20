import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String playlist;
  final int trackNum;
  final String image;

  PlaylistItem(
      {required this.playlist, required this.image, required this.trackNum});

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
              image: DecorationImage(
                image: NetworkImage("https://openwhyd.org" + image),
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
                  playlist,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      "Tracks: ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      trackNum.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
