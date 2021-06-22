import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
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

Future<dynamic> signIn(String email, String password) async {
  password = crypto.md5.convert(utf8.encode(password)).toString();
  final res = await http.get(Uri.parse(
      'https://openwhyd.org/login?action=login&ajax=true&email=$email&md5=$password&includeUser=true'));

  print(res.statusCode);
  print(res.request);
  print(res.headers);

  if (res.statusCode == 200) {
    final jsonData = jsonDecode(res.body);
    //final head = jsonDecode(res.headers);
    // return User.fromJson(jsonDecode(res.body));
    // return type = dynamic; returning a json object from res.body due to loggin in succesfully return only a redirection url;
    print(jsonData);

    globals.id = jsonData["user"]["_id"];
    globals.userName = jsonData["user"]["name"];
    print(globals.id);
    print(globals.userName);

    globals.cookieFind = res.headers['set-cookie'];
    globals.cookieChange = globals.cookieFind.split(RegExp(r"; "));
    print(globals.cookieFind);
    print(globals.cookieChange);
    print(globals.cookieChange[0]);

    // var jar = CookieJar();
    // await jar.saveFromResponse(
    //     Uri.parse('https://openwhyd.org/login?action=login&ajax=true&email=$email&md5=$password&includeUser=true'),
    //     res.headers['set-cookie']);
    // globals.cream = new Cookie.fromJson(res.headers);
    // print(globals.cream);

    if (jsonData["redirect"] != null) {
      return jsonData;
    }
    throw Exception(jsonData["error"]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to login.');
  }
  //print('4');
}

Future<List<TrackModel>> fetchHotTracks() async {
  final response =
      await http.get(
        Uri.parse("https://openwhyd.org/hot/1?format=json"),
        headers: <String, String>{
          "Cookie": globals.cookieChange[0],
        },
      );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return HotTracks.fromJson(jsonDecode(response.body)).tracks;
  } else {
    throw Exception('Failed to load tracks');
  }
}

Future<List<TrackModel>> fetchLikedTracks() async {
  //var findUser = "https://openwhyd.org/api/user?id=" + globals.id;
  //final result = await http.get(Uri.parse(findUser));

  // if (result.statusCode == 200) {
    //var res = jsonDecode(result.body);
    var findURL =
        "https://openwhyd.org/u/" + globals.id + "/likes?format=json";

    final response = await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      //print(response.body);
      return PlaylistTracksList.fromJson(jsonDecode(response.body)).song;
    } else {
      throw Exception('Failed to load liked tracks');
    }
  // } else {
  //   throw Exception('Failed to find user');
  // }
}

Future<List<PlaylistModel>> fetchPlaylist() async {
  //Cookie chip = getCookie("whydSid");
  //, headers: {HttpHeaders.authorizationHeader: chip}

  print(globals.id);
  // var findUser = "https://openwhyd.org/api/user?id=" + globals.id;
  // final result = await http.get(Uri.parse(findUser));

  // if (result.statusCode == 200) {
  //   var res = jsonDecode(result.body);
    var findURL = "https://openwhyd.org/u/" +
        globals.id +
        "/playlists?format=json";

    final response = await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      return UserPlaylist.fromJson(jsonDecode(response.body)).playlists;
    } else {
      throw Exception('Failed to load playlists');
    }
  // } else {
  //   throw Exception('Failed to find user');
  // }
}

Future<List<TrackModel>> fetchPlaylistTracks(int num) async {
  //var findUser = "https://openwhyd.org/api/user?id=" + globals.id;
  //final result = await http.get(Uri.parse(findUser));

  // if (result.statusCode == 200) {
  //   var res = jsonDecode(result.body);
    var findURL = "https://openwhyd.org/u/" +
        globals.id +
        "/playlist/" +
        num.toString() +
        "?format=json";

    final response = await http.get(Uri.parse(findURL));
    if (response.statusCode == 200) {
      return PlaylistTracksList.fromJson(jsonDecode(response.body)).song;
    } else {
      throw Exception('Failed to load playlist tracks');
    }
  // } else {
  //   throw Exception('Failed to find user');
  // }
}
