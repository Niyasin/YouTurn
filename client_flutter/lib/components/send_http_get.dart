import 'dart:convert';

import 'package:client_flutter/components/tag_data.dart';

import 'new_tag_payload.dart';
import 'package:http/http.dart' as http;

Future<Tag> sendHttpGet({
  required String lat,
  required String lng,
}) async {
  String uri = "192.168.249.183:8080";

  final url = Uri.parse("http://$uri/check/?lat=$lat&lng=$lng");

  var res = await http.get(url);
  var body = res.body.toString();
  print("Body is: $body");
  if (res.statusCode >= 200 && res.statusCode <= 299) {
    dynamic body = jsonDecode(res.body);
    Tag tag = Tag.fromJson(body);
    return tag;
  } else {
    throw "Unable to retrieve data";
  }

  //Map<String, dynamic> resMap = jsonDecode(res.body);
  // print(resMap);
  //return resMap["success"];
}

Future<List<Tag>> httpGetAllMarkers(lat, lng) async {
  lat ?? 11.605;
  lng ?? 76.083;
  String uri = "192.168.249.183:8080";
  final url = Uri.parse(

      //"http://192.168.155.183:8080/loaddata/?lat=$lat&lng=$lng&range=5000"
      "http://$uri/loaddata/?lat=11.32631111368894&lng=75.97189772534205&range=5000");

  var res = await http.get(url);
  var body = res.body.toString();
  print("Body is: $body");
  if (res.statusCode >= 200 && res.statusCode <= 299) {
    List<dynamic> body = jsonDecode(res.body);

    List<Tag> tags = body
        .map(
          (dynamic item) => Tag.fromJson(item),
        )
        .toList();
    return tags;
  } else {
    throw "Unable to retrieve data";
  }
  //Map<String, dynamic> resMap = jsonDecode(res.body);
  // print(resMap);
  //return resMap["success"];
}
