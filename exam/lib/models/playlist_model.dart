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
