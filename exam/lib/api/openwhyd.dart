import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/models/hot_tracks.dart';
import 'package:openwhyd_api_music_app/models/playlist_model.dart';
import 'package:openwhyd_api_music_app/models/playlist_tracks_model.dart';
import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;
import 'package:openwhyd_api_music_app/models/user_playlist.dart';

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

Future<List<PlaylistTracksModel>> fetchLikedTracks() async {
  var findUser = "https://openwhyd.org/api/user?id=" + globals.id;

  final result = await http.get(
      Uri.parse(findUser));

  if (result.statusCode == 200) {
    var res = jsonDecode(result.body);
    var findURL = "https://openwhyd.org/u/" + res["id"].toString() + "/likes?format=json";

    final response =
    await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      return PlaylistTracksList.fromJson(jsonDecode(response.body)).song;
    } else {
      throw Exception('Failed to load liked tracks');
    }
  } else {
    throw Exception('Failed to find user');
  }
}

Future<List<PlaylistModel>> fetchPlaylist() async {
  //Cookie chip = getCookie("whydSid");
  //, headers: {HttpHeaders.authorizationHeader: chip}

  print(globals.id);
  var findUser = "https://openwhyd.org/api/user?id=" + globals.id;

  final result = await http.get(Uri.parse(findUser));

  if (result.statusCode == 200) {
    var res = jsonDecode(result.body);
    var findURL = "https://openwhyd.org/u/" +
        res["id"].toString() +
        "/playlists?format=json";

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

Future<List<TrackModel>> fetchPlaylistTracks(int num) async {
  var findUser = "https://openwhyd.org/api/user?id=" + globals.id;

  final result = await http.get(Uri.parse(findUser));

  if (result.statusCode == 200) {
    var res = jsonDecode(result.body);
    var findURL = "https://openwhyd.org/u/" +
        res["id"].toString() +
        "/playlist/" +
        num.toString() +
        "?format=json";

    final response = await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      return PlaylistTracksList.fromJson(jsonDecode(response.body)).song;
    } else {
      throw Exception('Failed to load playlist tracks');
    }
  } else {
    throw Exception('Failed to find user');
  }
}
