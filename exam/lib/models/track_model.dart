class HotTracks {
  final List<TrackModel> tracks;

  HotTracks({required this.tracks});

  factory HotTracks.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['tracks'] as List;
    List<TrackModel> tracksList =
        list.map((i) => TrackModel.fromJson(i)).toList();

    return HotTracks(tracks: tracksList);
  }
}

class TrackModel {
  late String trackName;
  late String? userName;
  late String image;
  late String audio;

  TrackModel(
      {required this.trackName,
      required this.image,
      required this.audio,
      this.userName});

  factory TrackModel.fromJson(Map<String, dynamic> parsedjson) {
    String link = parsedjson['eId'];
    // link = 'https://www.youtube.com/watch?v=' + link.substring(4);
    link = link.substring(4);
    return TrackModel(
      trackName: parsedjson['name'],
      userName: parsedjson['uNm'] ?? 'unknown',
      image: parsedjson['img'],
      audio: link,
    );
  }
}
