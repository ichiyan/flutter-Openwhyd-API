import 'package:openwhyd_api_music_app/models/playlist_model.dart';

class UserPlaylist {
  final List<PlaylistModel> playlists;

  UserPlaylist({required this.playlists});

  factory UserPlaylist.fromJson(var parsedJson) {
    List<PlaylistModel> allPlaylists = new List.empty(growable: true);
    for (var i = 0; i < parsedJson.length; i++) {
      var object = parsedJson[i];
      PlaylistModel newPlaylist = new PlaylistModel(
          playlist: object["name"],
          image: object["img"],
          trackNum: object["nbTracks"]);
      allPlaylists.add(newPlaylist);
    }

    return UserPlaylist(playlists: allPlaylists);
  }
}
