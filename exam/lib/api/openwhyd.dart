import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
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

Future<List<PlaylistModel>> fetchPlaylist() async {
  final result = await http.get(
      Uri.parse("https://openwhyd.org/api/user?id=60cf20eb08ced3543d81c3d2"));
  //REMOVE THE ID PARAMETER ONCE LOGIN HAS BEEN FIXED

  if (result.statusCode == 200) {
    var res = jsonDecode(result.body);
    var findURL =
        "https://openwhyd.org/u/" + res["id"] + "/playlists?format=json";

    final response = await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      return UserPlaylist.fromJson(jsonDecode(response.body)).playlists;
    } else {
      throw Exception('Failed to load playlists');
    }
  } else {
    throw Exception('Failed to find user');
  }
}
