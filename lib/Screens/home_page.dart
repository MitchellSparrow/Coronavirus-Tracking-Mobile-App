import 'package:coronatracker/models/album.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePageWidget extends StatefulWidget {
  Future<Album> futureAblbum;
  HomePageWidget({this.futureAblbum});
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData(int confirmed, int deaths, int recovered) {
    var pieData = [
      new Task("Confirmed", confirmed, Color.fromRGBO(0, 102, 102, 1)),
      new Task("Deaths", deaths, Color.fromRGBO(0, 204, 204, 1)),
      new Task("Recovered", recovered, Color.fromRGBO(0, 224, 224, 1)),
    ];

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: "Daily Task",
        labelAccessorFn: (Task row, _) => '${row.taskValue}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Statistics',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 102, 102, 1),
      ),
      home: Scaffold(
          body: Center(
        child: FutureBuilder<Album>(
            future: widget.futureAblbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _generateData(snapshot.data.confirmed, snapshot.data.deaths,
                    snapshot.data.recovered);
                //return Text(snapshot.data.locations);
                return Container(
                  padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: 250,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromRGBO(0, 102, 102, 1),
                                      Color.fromRGBO(0, 204, 204, 1),
                                    ]),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60)),
                                border:
                                    Border.all(color: Colors.white, width: 0)),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Text(
                                    "COVID-19",
                                    style: new TextStyle(
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45,
                                        color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 240,
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        "Confirmed:",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "${snapshot.data.confirmed}",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 240,
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        "Deaths:",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "${snapshot.data.deaths}",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 240,
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        "Recovered:",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "${snapshot.data.recovered}",
                                        style: new TextStyle(
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                          flex: 10,
                          child: Container(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            color: Colors.white,
                            child: charts.PieChart(
                              _seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 1),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                      charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxColumns: 1,
                                  cellPadding:
                                      new EdgeInsets.only(right: 4, bottom: 4),
                                  entryTextStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.black,
                                    fontFamily: 'Avenir',
                                    fontSize: 20,
                                  ),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 40,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.outside)
                                  ]),
                            ),
                          )),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }),
      )),
    );
  }
}

class Task {
  String task;
  int taskValue;
  Color colorValue;
  Task(this.task, this.taskValue, this.colorValue);
}
