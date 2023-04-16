import 'new_tag_payload.dart';
import 'package:http/http.dart' as http;

Future<String> sendHttpPost({
  required String lat,
  required String lng,
  required String range,
  required String type,
  required String desc,
  required String date,
  required String up,
  required String down,
}) async {
  String uri = "192.168.249.183:8080";
  final url = Uri.parse("http://$uri/add");

  try {
    var payload = NewTagPayload(
        lat: lat,
        lng: lng,
        range: range,
        type: type,
        desc: desc,
        date: date,
        up: up,
        down: down);
    //print(payload.toJson());
    var res = await http.post(url, body: payload.toJson());
    print("Post Body is $res.body");
    if (res.statusCode >= 200 && res.statusCode <= 299) {
      return "Success";
    } else if (res.statusCode >= 300 && res.statusCode <= 399) {
      return "Redirection Error";
    } else if (res.statusCode >= 400 && res.statusCode <= 499) {
      return "Server not found";
    } else if (res.statusCode >= 500 && res.statusCode <= 599) {
      return "Internal server error";
    } else {
      return "Unknown error";
    }
  } on Exception catch (e) {
    return e.toString();
  }
  //Map<String, dynamic> resMap = jsonDecode(res.body);
  // print(resMap);
  //return resMap["success"];
}

Future<String> doUpVotePost({
  required String lat,
  required String lng,
  required String range,
  required String type,
  required String desc,
  required String date,
  required String up,
  required String down,
}) async {
  String uri = "192.168.249.183:8080";
  final url = Uri.parse("http://$uri/upvote");

  try {
    var payload = NewTagPayload(
        lat: lat,
        lng: lng,
        range: range,
        type: type,
        desc: desc,
        date: date,
        up: up,
        down: down);
    //print(payload.toJson());
    var res = await http.post(url, body: payload.toJson());
    print("Post Body is $res.body");
    if (res.statusCode >= 200 && res.statusCode <= 299) {
      return "Success";
    } else if (res.statusCode >= 300 && res.statusCode <= 399) {
      return "Redirection Error";
    } else if (res.statusCode >= 400 && res.statusCode <= 499) {
      return "Server not found";
    } else if (res.statusCode >= 500 && res.statusCode <= 599) {
      return "Internal server error";
    } else {
      return "Unknown error";
    }
  } on Exception catch (e) {
    return e.toString();
  }
  //Map<String, dynamic> resMap = jsonDecode(res.body);
  // print(resMap);
  //return resMap["success"];
}

Future<String> doDownVotePost({
  required String lat,
  required String lng,
  required String range,
  required String type,
  required String desc,
  required String date,
  required String up,
  required String down,
}) async {
  String uri = "192.168.249.183:8080";
  final url = Uri.parse("http://$uri/downvote");

  try {
    var payload = NewTagPayload(
        lat: lat,
        lng: lng,
        range: range,
        type: type,
        desc: desc,
        date: date,
        up: up,
        down: down);
    //print(payload.toJson());
    var res = await http.post(url, body: payload.toJson());
    print("Post Body is $res.body");
    if (res.statusCode >= 200 && res.statusCode <= 299) {
      return "Success";
    } else if (res.statusCode >= 300 && res.statusCode <= 399) {
      return "Redirection Error";
    } else if (res.statusCode >= 400 && res.statusCode <= 499) {
      return "Server not found";
    } else if (res.statusCode >= 500 && res.statusCode <= 599) {
      return "Internal server error";
    } else {
      return "Unknown error";
    }
  } on Exception catch (e) {
    return e.toString();
  }
  //Map<String, dynamic> resMap = jsonDecode(res.body);
  // print(resMap);
  //return resMap["success"];
}
