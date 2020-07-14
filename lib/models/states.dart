import 'package:flutter/cupertino.dart';

class StateModel {
  final name;
  final active;
  final recovered;
  final deaths;
  final confirmed;
  final time;

  StateModel(
      {@required this.name,
      @required this.active,
      @required this.deaths,
      @required this.recovered,
      @required this.confirmed,
      @required this.time});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        name: json['state'].toString(),
        active: json['active'].toString(),
        deaths: json['deaths'].toString(),
        recovered: json['recovered'].toString(),
        confirmed: json['confirmed'].toString(),
        time: json['lastupdatedtime'].toString());
  }
}
