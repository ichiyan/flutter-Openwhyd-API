import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/models/track_model.dart';

// Future<List<dynamic>> getHotTracks() async {
//   var response = await http.get(Uri.parse(apiUrl));
//   var trackList = json.decode(response.body)['tracks'];
//   return trackList;
// }

Future<List<TrackModel>> fetchHotTracks() async {
  final response =
      await http.get(Uri.parse("https://openwhyd.org/hot/1?format=json"));
  if (response.statusCode == 200) {
    return HotTracks.fromJson(jsonDecode(response.body)).tracks;
  } else {
    throw Exception('Failed to load tracks');
  }
}
