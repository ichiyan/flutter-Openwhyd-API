import 'package:openwhyd_api_music_app/models/track_model.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;

class HotTracks {
  final List<TrackModel> tracks;

  HotTracks({required this.tracks});

  factory HotTracks.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['tracks'] as List;
    List<TrackModel> tracksList =
        list.map((i) => TrackModel.fromJson(i)).toList();
    //       {
    //         globals.heartColorG = "n";
    //         print(globals.heartColorG);
    //         globals.trackStatus(i['_id']);
    //         return TrackModel.fromJson(i, globals.heartColorG);
    //       }

    // List<TrackModel> tracksList = new List.empty(growable: true);
    // for(var i=0; i<list.length; i++){
    //   globals.trackStatus(list[i]['_id']);
    //   print(globals.heartColorG);
    //
    //   TrackModel newT = new TrackModel(
    //     trackName: list[i]["name"],
    //     image: list[i]["img"],
    //     userName: list[i]["uNm"],
    //     audio: list[i]['eId'].substring(4),
    //     id: list[i]['_id'],
    //     heartColor: globals.heartColorG,
    //   );
    //   tracksList.add(newT);
    // }

    return HotTracks(tracks: tracksList);
  }
}
