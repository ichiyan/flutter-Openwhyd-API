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

  TrackModel({required this.trackName, required this.image, this.userName});

  factory TrackModel.fromJson(Map<String, dynamic> parsedjson) {
    return TrackModel(
      trackName: parsedjson['name'],
      userName: parsedjson['uNm'] ?? 'unknown',
      image: parsedjson['img'],
    );
  }
}
