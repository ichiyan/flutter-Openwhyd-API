import 'package:exam/components/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackList extends StatelessWidget {
  final String apiUrl = "https://openwhyd.org/hot/1?format=json";

  Future<List<dynamic>> getTracks() async {
    var result = await http.get(Uri.parse(apiUrl));
    var jsonData = json.decode(result.body)['tracks'];
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track List'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getTracks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => CustomListTile(
                  onTap: () {},
                  title: snapshot.data[index]['name'],
                  // user: snapshot.data[index]['uNm'],
                  img: snapshot.data[index]['img'],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
