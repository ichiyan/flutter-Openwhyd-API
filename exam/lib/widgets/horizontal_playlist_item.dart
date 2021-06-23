import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalPlaylistItem extends StatelessWidget {
  final String title;
  final String image;

  const HorizontalPlaylistItem(
      {Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 210.0,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      width: 215,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
              ],
            ),
        ),
    );
  }
}
