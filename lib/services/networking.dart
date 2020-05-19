import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking(this.url);
  final String url;
  String data;

  Future getData() async {
    http.Response response = await http
        .get(url); //fechting networking data using get method from internet
    if (response.statusCode == 200) {
      data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
