import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.get(Uri.parse(url));

    print(id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
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
