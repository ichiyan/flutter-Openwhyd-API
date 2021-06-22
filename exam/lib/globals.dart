library my_prj.globals;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webdriver/sync_core.dart';
import 'package:openwhyd_api_music_app/globals.dart' as globals;

Cookie chip = Cookie("whydSid", null);
String id = "";
var cookieFind;
var cookieChange;
var cream;
var vanilla;
String heartColorG = "";
String userName = "";

Future<void> trackStatus(String id) async {
  var url = "https://openwhyd.org/api/post?action=lovers&pId="+id;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);

    for (var i = 0; i < result.length; i++){
      if(result[i]["id"].toString() == globals.id){
        // print("result:");
        // print(result);
        globals.heartColorG = "red";
      } else {
        globals.heartColorG = "white";
      }
    }
    print(globals.heartColorG);
  } else {
    throw Exception('Failed to find track');
  }
}