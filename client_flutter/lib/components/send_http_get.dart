import 'new_tag_payload.dart';
import 'package:http/http.dart' as http;

Future<String> sendHttpGet({
  required String lat,
  required String lng,
}) async {
  final url = Uri.parse("http://192.168.89.183:8080/check/?lat=$lat&lng=$lng");

  try {
    var res = await http.get(url);
    var body = res.body.toString();
    //print("Body is: $body");
    if (res.statusCode >= 200 && res.statusCode <= 299) {
      return body;
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
