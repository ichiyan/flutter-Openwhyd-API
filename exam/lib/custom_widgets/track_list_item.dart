import 'package:flutter/material.dart';

class TrackListItem extends StatelessWidget {
  final String trackName;
  final String? userName;
  final String image;

  TrackListItem({required this.trackName, required this.image, this.userName});

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
                image: NetworkImage(image),
              ),
            ),
            // child: FadeInImage.assetNetwork(
            //   placeholder: 'assets/21e5bbdad00c1a48783975d8b13acdd5.jpg',
            //   image: image,
            // ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(16.0),
          //   child: Image.network(
          //     image,
          //     height: 80.0,
          //     width: 80.0,
          //     fit: BoxFit.fill,
          //   ),
          // ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
