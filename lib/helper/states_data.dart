import 'dart:convert';
import 'package:covidmah/models/states.dart';
import 'package:http/http.dart' as http;

class StatesData {
  Future<List<StateModel>> fetchPosts() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    var responseJson = json.decode(response.body);
    return (responseJson['statewise'] as List)
        .map((p) => StateModel.fromJson(p))
        .toList();
  }
}
