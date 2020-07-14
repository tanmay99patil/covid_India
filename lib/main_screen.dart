import 'package:covidmah/helper/states_data.dart';
import 'package:covidmah/models/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helper/states_data.dart';
import 'widgets/state_card.dart';

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
                    return Text("Error Loading Data");
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
