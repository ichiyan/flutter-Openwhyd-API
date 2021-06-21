class PlaylistTracksList {
  final List<PlaylistTracksModel> song;

  PlaylistTracksList({required this.song});

  factory PlaylistTracksList.fromJson(var parsedJson) {
    List<PlaylistTracksModel> allPlaylists = new List.empty(growable: true);
    for(var i=0; i<parsedJson.length; i++){
      var object = parsedJson[i];
      PlaylistTracksModel newPlaylist = new PlaylistTracksModel(songTitle: object["name"],
          image: object["img"], name: object["uNm"], playlistName: object['pl']['name'], );
      allPlaylists.add(newPlaylist);
    }

    return PlaylistTracksList(song: allPlaylists);
  }
}

class PlaylistTracksModel {
  late String songTitle;
  late String name;
  late String image;
  late String playlistName;

  PlaylistTracksModel({required this.songTitle, required this.image, required this.name, required this.playlistName});

  factory PlaylistTracksModel.fromJson(Map<String, dynamic> parsedjson) {
    return PlaylistTracksModel(
      songTitle: parsedjson['name'] as String,
      name: parsedjson['uNm'] as String,
      image: parsedjson['img'] as String,
      playlistName: parsedjson['pl']['name'] as String,
    );
  }
}
