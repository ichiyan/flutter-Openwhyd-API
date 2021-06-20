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

class PlaylistModel {
  late String playlist;
  late int trackNum;
  late String image;

  PlaylistModel(
      {required this.playlist, required this.image, required this.trackNum});

  factory PlaylistModel.fromJson(Map<String, dynamic> parsedjson) {
    return PlaylistModel(
      playlist: parsedjson['name'] as String,
      trackNum: parsedjson['nbTracks'] as int,
      image: parsedjson['img'] as String,
    );
  }
}
