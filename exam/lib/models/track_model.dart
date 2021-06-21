class TrackModel {
  late String trackName;
  late String? userName;
  late String? playlistName;
  late String image;
  late String audio;
  late String id;
  late String? like;

  TrackModel(
      {required this.trackName,
      required this.image,
      required this.audio,
        required this.id,
        this.like,
      this.playlistName,
      this.userName});

  factory TrackModel.fromJson(Map<String, dynamic> parsedjson) {
    if (parsedjson.containsKey('pl')) {
      if(parsedjson.containsKey('isLoved')){
        return TrackModel(
          trackName: parsedjson['name'] as String,
          userName: parsedjson['uNm'] ?? 'unknown',
          playlistName: parsedjson['pl']['name'],
          image: parsedjson['img'] as String,
          audio: parsedjson['eId'],
          id: parsedjson['_id'],
          like: parsedjson['isLoved'],
        );
      }else{
        return TrackModel(
          trackName: parsedjson['name'] as String,
          userName: parsedjson['uNm'] ?? 'unknown',
          playlistName: parsedjson['pl']['name'],
          image: parsedjson['img'] as String,
          audio: parsedjson['eId'],
          id: parsedjson['_id'],
          like: "false",
        );
      }
    } else {
      if(parsedjson.containsKey('isLoved')){
        return TrackModel(
          trackName: parsedjson['name'] as String,
          userName: parsedjson['uNm'] ?? 'unknown',
          image: parsedjson['img'] as String,
          audio: parsedjson['eId'],
          id: parsedjson['_id'],
          like: parsedjson['isLoved'],
        );
      }else{
        return TrackModel(
          trackName: parsedjson['name'] as String,
          userName: parsedjson['uNm'] ?? 'unknown',
          image: parsedjson['img'] as String,
          audio: parsedjson['eId'],
          id: parsedjson['_id'],
          like: "true",
        );
      }
    }
  }
}
