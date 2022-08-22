import 'dart:convert';

import 'package:http/http.dart' as http;

class GoogleAPI {
  Future<http.Response> getPlace() async {
    String _url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants%20in%20Bangkok&key=AIzaSyBXKNNR4zCG_9TKp_6XaBfZk0FsLdS0NRY";
    var header = {
      'Content-Type': 'application/json',
    };
    print(_url);
    print(header);
    return http.get(Uri.parse(_url), headers: header);
  }

  Future<http.Response> searchRestaurant(String text) async {
    String _url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$text%20restaurants%20in%20Bangkok&key=AIzaSyBXKNNR4zCG_9TKp_6XaBfZk0FsLdS0NRY";
    var header = {
      'Content-Type': 'application/json',
    };
    print(_url);
    print(header);
    return http.get(Uri.parse(_url), headers: header);
  }
}
