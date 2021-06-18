import 'dart:async';
import 'dart:convert';

class Track {
  Track({
    required this.id,
    required this.uId,
    required this.uNm,
    required this.text,
    required this.name,
    required this.eId,
    required this.ctx,
    required this.img,
    // required this.src,
  });

  String id;
  String uId;
  String uNm;
  String text;
  String name;
  String eId;
  String ctx;
  String img;
  // String src;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["_id"],
        uId: json["uId"],
        uNm: json["uNm"],
        text: json["text"],
        name: json["name"],
        eId: json["eId"],
        ctx: json["ctx"],
        img: json["img"],
        // src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uId": uId,
        "uNm": uNm,
        "text": text,
        "name": name,
        "eId": eId,
        "ctx": ctx,
        "img": img,
      };
}
