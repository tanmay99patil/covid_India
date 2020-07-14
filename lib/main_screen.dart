import 'package:covidmah/helper/states_data.dart';
import 'package:covidmah/models/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helper/states_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = StatesData().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Covid India',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            FutureBuilder<List<StateModel>>(
                future: StatesData().fetchPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<StateModel> data = snapshot.data;
                    return Column(
                        children: data
                            .map(
                              (lists) => StateCard(
                                  recovered: lists.recovered,
                                  active: lists.active,
                                  name: lists.name,
                                  confirmed: lists.confirmed,
                                  time: lists.time,
                                  death: lists.deaths),
                            )
                            .toList());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}

class StateCard extends StatelessWidget {
  final name;
  final active, recovered, death, confirmed, time;
  StateCard(
      {@required this.recovered,
      @required this.active,
      @required this.name,
      @required this.confirmed,
      @required this.death,
      @required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 8),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            '$name',
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 3,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Last update: $time',
              style: TextStyle(fontSize: 10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.local_hospital,
                      color: Color(0xff398E3D),
                    ),
                    Text('Confirmed'),
                    Text(
                      confirmed.toString(),
                      style: TextStyle(color: Color(0xff398E3D)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.virus,
                      color: Color(0xffFF6E00),
                    ),
                    Text(
                      'Active',
                    ),
                    Text(
                      '$active',
                      style: TextStyle(color: Color(0xffFF6E00)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.bed,
                      color: Color(0xff1A77D4),
                    ),
                    Text('Recovered'),
                    Text(
                      '${recovered.toString()}',
                      style: TextStyle(
                        color: Color(0xff1A77D4),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.skullCrossbones,
                      color: Color(0xffD32F2E),
//                        0xffFF6E00
                    ),
                    Text('Death'),
                    Text(
                      death.toString(),
                      style: TextStyle(color: Color(0xffD32F2E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
