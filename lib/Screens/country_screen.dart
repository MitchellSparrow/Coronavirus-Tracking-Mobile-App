import 'package:coronatracker/Screens/list_view.dart';
import 'package:coronatracker/models/album.dart';
import 'package:coronatracker/models/size_config.dart';
import 'package:coronatracker/models/task.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'loading.dart';

class CountryScreen extends StatefulWidget {
  Future<CountryList> futureAblbum;
  int index;
  CountryScreen({this.futureAblbum, this.index});
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen>
    with AutomaticKeepAliveClientMixin<CountryScreen> {
  List<charts.Series<Task, String>> _seriesPieData1;
  List<charts.Series<Task, String>> _seriesPieData2;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();
  bool loading = false;

  Future<CountryList> fetchCountryAlbum() async {
    final response = await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      loading = false;
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("Country List Data Loaded Successfully");
      return CountryList.fromJson(convert.jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load album');
    }
  }

  Future<Null> refreshList() async {
    Future<CountryList> countryAlbum;
    refreshKey.currentState?.show(atTop: false);
    refreshKey1.currentState?.show(atTop: false);
    setState(() {
      loading = true;
    });
    countryAlbum = fetchCountryAlbum();
    setState(() {
      widget.futureAblbum = countryAlbum;
    });
    return null;
  }

  _generateData(int confirmed, int deaths, int recovered, int todayDeaths,
      int todayCases, int critical) {
    var pieData1 = [
      new Task(
          "Cases: ${confirmed}", confirmed, Color.fromRGBO(0, 102, 102, 1)),
      new Task("Deaths: ${deaths}", deaths, Color.fromRGBO(0, 184, 184, 1)),
      new Task(
          "Recovered: ${recovered}", recovered, Color.fromRGBO(0, 234, 234, 1)),
    ];

    var pieData2 = [
      new Task(
          "Cases: ${todayCases}", todayCases, Color.fromRGBO(0, 102, 102, 1)),
      new Task("Deaths: ${todayDeaths}", todayDeaths,
          Color.fromRGBO(0, 184, 184, 1)),
      new Task(
          "Critical: ${critical}", critical, Color.fromRGBO(0, 234, 234, 1)),
    ];

    _seriesPieData1.add(
      charts.Series(
        data: pieData1,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: "Daily Task",
        labelAccessorFn: (Task row, _) => '${row.taskValue}',
      ),
    );

    _seriesPieData2.add(
      charts.Series(
        data: pieData2,
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
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 102, 102, 1),
        accentColor: Color.fromRGBO(0, 102, 102, 1),
        hintColor: Color.fromRGBO(0, 102, 102, 1),
      ),
      home: Material(
        child: FutureBuilder<CountryList>(
            future: widget.futureAblbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _seriesPieData1 = List<charts.Series<Task, String>>();
                _seriesPieData2 = List<charts.Series<Task, String>>();
                _generateData(
                    snapshot.data.countries[widget.index].countryCases,
                    snapshot.data.countries[widget.index].countryDeaths,
                    snapshot.data.countries[widget.index].countryRecoveries,
                    snapshot.data.countries[widget.index].countryTodayDeaths,
                    snapshot.data.countries[widget.index].countryTodayCases,
                    snapshot.data.countries[widget.index].countryCritical);
                return loading
                    ? Loading()
                    : RefreshIndicator(
                        key: refreshKey1,
                        onRefresh: refreshList,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 50,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  top: SizeConfig.safeBlockVertical * 8,
                                  bottom: SizeConfig.safeBlockVertical * 2,
                                  left: SizeConfig.safeBlockHorizontal * 9,
                                  right: SizeConfig.safeBlockHorizontal * 4.5),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_back_ios),
                                              color: Color.fromRGBO(
                                                  0, 102, 102, 1),
                                              iconSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  7.5,
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ListViewWidget(
                                                            futureAblbum: widget
                                                                .futureAblbum,
                                                          )),
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            flex: 12,
                                            child: Text(
                                              snapshot
                                                  .data
                                                  .countries[widget.index]
                                                  .country,
                                              textAlign: TextAlign.center,
                                              style: new TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      8.5,
                                                  color: Color.fromRGBO(
                                                      0, 102, 102, 1)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                          ),
                                        ]),
                                      )),
                                  Expanded(flex: 1, child: SizedBox()),
                                  Expanded(
                                    flex: 11,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(flex: 1, child: SizedBox()),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Total:",
                                                  textAlign: TextAlign.left,
                                                  style: new TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5.5,
                                                      color: Color.fromRGBO(
                                                          0, 122, 122, 1)),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Recoveries/Total Cases:\n${((snapshot.data.countries[widget.index].countryRecoveries / snapshot.data.countries[widget.index].countryCases) * 100).toStringAsFixed(2)} %\n\n\nDeaths/Total Cases:\n${((snapshot.data.countries[widget.index].countryDeaths / snapshot.data.countries[widget.index].countryCases) * 100).toStringAsFixed(2)} %",
                                                    style: new TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3,
                                                        color: Colors.black),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .safeBlockHorizontal *
                                                      9,
                                                  right: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3),
                                              color: Colors.white,
                                              child: charts.PieChart(
                                                _seriesPieData1,
                                                animate: true,
                                                animationDuration:
                                                    Duration(seconds: 1),
                                                behaviors: [
                                                  new charts.DatumLegend(
                                                    outsideJustification: charts
                                                        .OutsideJustification
                                                        .endDrawArea,
                                                    horizontalFirst: false,
                                                    desiredMaxColumns: 1,
                                                    cellPadding:
                                                        new EdgeInsets.only(
                                                      right: 0,
                                                      bottom: SizeConfig
                                                              .safeBlockVertical *
                                                          0.5,
                                                    ),
                                                    entryTextStyle:
                                                        charts.TextStyleSpec(
                                                      color: charts
                                                          .MaterialPalette
                                                          .black,
                                                      fontFamily: 'Avenir',
                                                      fontSize: (SizeConfig
                                                                  .safeBlockHorizontal *
                                                              3)
                                                          .toInt(),
                                                    ),
                                                  )
                                                ],
                                                defaultRenderer: new charts
                                                        .ArcRendererConfig(
                                                    arcWidth: (SizeConfig
                                                                .safeBlockHorizontal *
                                                            5)
                                                        .toInt(),
                                                    arcRendererDecorators: []),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Expanded(flex: 2, child: SizedBox()),
                                  Expanded(
                                    flex: 11,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(flex: 1, child: SizedBox()),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Today:",
                                                  textAlign: TextAlign.left,
                                                  style: new TextStyle(
                                                      fontFamily: 'Avenir',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5.5,
                                                      color: Color.fromRGBO(
                                                          0, 122, 122, 1)),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Today's Cases/Total Cases:\n${((snapshot.data.countries[widget.index].countryTodayCases / snapshot.data.countries[widget.index].countryCases) * 100).toStringAsFixed(2)} %\n\n\nCritical/Total Cases:\n${((snapshot.data.countries[widget.index].countryCritical / snapshot.data.countries[widget.index].countryCases) * 100).toStringAsFixed(2)} %",
                                                    style: new TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: SizeConfig
                                                                .safeBlockHorizontal *
                                                            3,
                                                        color: Colors.black),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 20,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: SizeConfig
                                                          .safeBlockHorizontal *
                                                      9,
                                                  right: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3),
                                              color: Colors.white,
                                              child: charts.PieChart(
                                                _seriesPieData2,
                                                animate: true,
                                                animationDuration:
                                                    Duration(seconds: 1),
                                                behaviors: [
                                                  new charts.DatumLegend(
                                                    outsideJustification: charts
                                                        .OutsideJustification
                                                        .endDrawArea,
                                                    horizontalFirst: false,
                                                    desiredMaxColumns: 1,
                                                    cellPadding: new EdgeInsets
                                                            .only(
                                                        right: 0,
                                                        bottom: SizeConfig
                                                                .safeBlockVertical *
                                                            0.5),
                                                    entryTextStyle:
                                                        charts.TextStyleSpec(
                                                      color: charts
                                                          .MaterialPalette
                                                          .black,
                                                      fontFamily: 'Avenir',
                                                      fontSize: (SizeConfig
                                                                  .safeBlockHorizontal *
                                                              3)
                                                          .toInt(),
                                                    ),
                                                  )
                                                ],
                                                defaultRenderer: new charts
                                                        .ArcRendererConfig(
                                                    arcWidth: (SizeConfig
                                                                .safeBlockHorizontal *
                                                            5)
                                                        .toInt(),
                                                    arcRendererDecorators: []),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
              } else if (snapshot.hasError) {
                print("${snapshot.error}");
                return RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 50,
                      padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 8,
                            bottom: SizeConfig.safeBlockVertical * 6,
                            left: SizeConfig.safeBlockHorizontal * 9,
                            right: SizeConfig.safeBlockHorizontal * 4.5),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        color: Color.fromRGBO(0, 102, 102, 1),
                                        iconSize:
                                            SizeConfig.safeBlockHorizontal *
                                                7.5,
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListViewWidget(
                                                      futureAblbum:
                                                          widget.futureAblbum,
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(flex: 8, child: SizedBox())
                                  ]),
                                )),
                            Expanded(
                              flex: 8,
                              child: new Scaffold(
                                body: Container(
                                  padding: new EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 5,
                                    right: SizeConfig.safeBlockHorizontal * 5,
                                    top: SizeConfig.safeBlockVertical * 5,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Error while loading data\n\n\nPlease try again later",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Loading();
              }
            }),
      ),
    );
  }
}
