import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomListTile({
  required String title,
  String user = "Empty",
  String img = "https://i.ytimg.com/vi/vzWds5gWS6c/default.jpg",
  onTap,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(img),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          children: [
            SizedBox(
              width: 250,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              user,
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          ],
        )
      ],
    ),
  );
}
