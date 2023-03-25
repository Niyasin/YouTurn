import 'new_tag_payload.dart';
import 'package:http/http.dart' as http;

Future<String> sendHttpPost(
    {required String lat,
    required String lon,
    required String range,
    required String type}) async {
  final url = Uri.parse("http://192.168.89.183:8080/add");

  try {
    var payload = NewTagPayload(lat: lat, lon: lon, range: range, type: type);
    //print(payload.toJson());
    var res = await http.post(url, body: payload.toJson());
    //print(res.body);
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
