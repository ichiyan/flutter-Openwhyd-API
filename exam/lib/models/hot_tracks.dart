import 'package:openwhyd_api_music_app/models/track_model.dart';

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
