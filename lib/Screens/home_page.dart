import 'package:coronatracker/models/album.dart';
import 'package:coronatracker/models/size_config.dart';
import 'package:coronatracker/models/task.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'disclaimer.dart';
import 'home_page_error.dart';
import 'loading.dart';

class HomePageWidget extends StatefulWidget {
  Future<TotalsAlbum> futureAblbum;
  Future<TotalsAlbum> totalsAlbum;
  HomePageWidget({this.futureAblbum});
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with AutomaticKeepAliveClientMixin<HomePageWidget> {
  bool loading = false;
  List<charts.Series<Task, String>> _seriesPieData;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();

  Future<TotalsAlbum> fetchTotalsAlbum() async {
    final response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON, and print the data was loaded successfully to console
      print("Totals Data Loaded Successfully");
      return TotalsAlbum.fromJson(convert.jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load album');
    }
  }

  Future<Null> refreshList() async {
    Future<TotalsAlbum> totalsAlbum;
    refreshKey.currentState?.show(atTop: false);
    refreshKey1.currentState?.show(atTop: false);
    setState(() {
      loading = true;
    });
    totalsAlbum = fetchTotalsAlbum();
    setState(() {
      widget.futureAblbum = totalsAlbum;
    });
    return null;
  }

  _generateData(int confirmed, int deaths, int recovered) {
    var pieData = [
      new Task("Cases", confirmed, Color.fromRGBO(0, 102, 102, 1)),
      new Task("Deaths", deaths, Color.fromRGBO(0, 184, 184, 1)),
      new Task("Recovered", recovered, Color.fromRGBO(0, 234, 234, 1)),
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

  void _showDisclaimerPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DisclaimerBottomSheet();
        });
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
      title: 'Corona Statistics',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 102, 102, 1),
        accentColor: Color.fromRGBO(0, 102, 102, 1),
        hintColor: Color.fromRGBO(0, 102, 102, 1),
      ),
      home: Scaffold(
        body: Container(
          child: Center(
            child: FutureBuilder<TotalsAlbum>(
                future: widget.futureAblbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _seriesPieData = List<charts.Series<Task, String>>();
                    _generateData(snapshot.data.cases, snapshot.data.deaths,
                        snapshot.data.recovered);
                    return loading
                        ? Loading()
                        : RefreshIndicator(
                            key: refreshKey1,
                            onRefresh: refreshList,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                height: MediaQuery.of(context).size.height - 50,
                                padding:
                                    EdgeInsets.only(top: 0, left: 0, right: 0),
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        0, 102, 102, 1),
                                                    Color.fromRGBO(
                                                        0, 204, 204, 1),
                                                  ]),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(60),
                                                  bottomRight:
                                                      Radius.circular(60)),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 0)),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: SizeConfig
                                                        .safeBlockVertical *
                                                    8,
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .safeBlockVertical *
                                                    12,
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: SizedBox(),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 12,
                                                            child: Text(
                                                              "COVID-19",
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .safeBlockHorizontal *
                                                                          11,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.help),
                                                              color:
                                                                  Colors.white,
                                                              iconSize: SizeConfig
                                                                      .safeBlockVertical *
                                                                  4,
                                                              onPressed:
                                                                  () async {
                                                                _showDisclaimerPanel();
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: SizeConfig
                                                            .safeBlockHorizontal *
                                                        58,
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .safeBlockHorizontal *
                                                          14,
                                                    ),
                                                    child: Text(
                                                      "Cases:",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Text(
                                                      "${snapshot.data.cases}",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: SizeConfig
                                                            .safeBlockHorizontal *
                                                        58,
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .safeBlockHorizontal *
                                                          14,
                                                    ),
                                                    child: Text(
                                                      "Deaths:",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Text(
                                                      "${snapshot.data.deaths}",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: SizeConfig
                                                            .safeBlockHorizontal *
                                                        58,
                                                    padding: EdgeInsets.only(
                                                      left: SizeConfig
                                                              .safeBlockHorizontal *
                                                          14,
                                                    ),
                                                    child: Text(
                                                      "Recovered:",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Text(
                                                      "${snapshot.data.recovered}",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .safeBlockHorizontal *
                                                              6.5,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                        flex: 20,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .safeBlockHorizontal *
                                                  16,
                                              right: SizeConfig
                                                      .safeBlockHorizontal *
                                                  16),
                                          color: Colors.white,
                                          child: charts.PieChart(
                                            _seriesPieData,
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
                                                        right: 4, bottom: 4),
                                                entryTextStyle:
                                                    charts.TextStyleSpec(
                                                  color: charts
                                                      .MaterialPalette.black,
                                                  fontFamily: 'Avenir',
                                                  fontSize: (SizeConfig
                                                              .safeBlockHorizontal *
                                                          4.5)
                                                      .toInt(),
                                                ),
                                              )
                                            ],
                                            defaultRenderer: new charts
                                                    .ArcRendererConfig(
                                                arcWidth: (SizeConfig
                                                            .safeBlockHorizontal *
                                                        8)
                                                    .toInt(),
                                                arcRendererDecorators: [
                                                  new charts.ArcLabelDecorator(
                                                      labelPosition: charts
                                                          .ArcLabelPosition
                                                          .outside)
                                                ]),
                                          ),
                                        )),
                                  ],
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
                        child: HomePageError(),
                      ),
                    );
                  } else {
                    return Loading();
                  }
                  // By default, show a loading spinner.
                }),
          ),
        ),
      ),
    );
  }
}
