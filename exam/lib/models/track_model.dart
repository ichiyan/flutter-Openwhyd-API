class TrackModel {
  late String trackName;
  late String? userName;
  late String? playlistName;
  late String image;
  late String audio;

  TrackModel(
      {required this.trackName,
      required this.image,
      required this.audio,
      this.playlistName,
      this.userName});

  factory TrackModel.fromJson(Map<String, dynamic> parsedjson) {
    if (parsedjson.containsKey('pl')) {
      return TrackModel(
        trackName: parsedjson['name'] as String,
        userName: parsedjson['uNm'] ?? 'unknown',
        playlistName: parsedjson['pl']['name'],
        image: parsedjson['img'] as String,
        audio: parsedjson['eId'],
      );
    } else {
      return TrackModel(
        trackName: parsedjson['name'] as String,
        userName: parsedjson['uNm'] ?? 'unknown',
        image: parsedjson['img'] as String,
        audio: parsedjson['eId'],
      );
    }
  }
}
