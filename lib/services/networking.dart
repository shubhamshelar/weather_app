import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  final String stringUrl;

  Network(this.stringUrl);

  Future<dynamic> getResponse() async {
    var url = Uri.parse(stringUrl);
    var response = await http.get(url);
    var decodeResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print(decodeResponse['main']);
      return decodeResponse;
    } else {
      print(response.statusCode);
    }
  }
}
