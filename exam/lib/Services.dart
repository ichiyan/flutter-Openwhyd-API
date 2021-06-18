import 'dart:convert';

import 'Track.dart';
import 'package:http/http.dart' as http;

class Services {
  String url = 'https://openwhyd.org/hot?format=json';

  Future<List<Track>> getTracks() async {
    // response is of type Response
    // ignore: unused_local_variable
    var response = await http.get(Uri.parse(url));

    try {
      var jsonData = jsonDecode(response.body)["tracks"] as Iterable;
      // List<Track> tracks = jsonDecode(response.body)["tracks"] as List<Track>;
      List<Track> tracks =
          List<Track>.from(jsonData.map((e) => Track.fromJson(e)));

      return tracks;
    } catch (e) {
      return [];
    }
  }
}
