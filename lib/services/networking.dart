import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:sky_engine/convert/';
import 'dart:convert';

const kapikey = 'abcf902cf40a3c7865a24cf0563757d8';

class Network {
  final double? lat, lon;
  Network(this.lat, this.lon);
  Future<void> getResponse() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$kapikey");
    var response = await http.get(url);
    var decodeResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(decodeResponse['main']);
    } else {
      print(response.statusCode);
    }
  }
}
