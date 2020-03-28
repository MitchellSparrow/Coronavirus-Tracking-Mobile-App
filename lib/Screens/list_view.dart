import 'dart:async';
import 'package:coronatracker/Screens/country_screen.dart';
import 'package:coronatracker/Screens/list_view_error.dart';
import 'package:coronatracker/models/album.dart';
import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'loading.dart';

class ListViewWidget extends StatefulWidget {
  Future<CountryList> futureAblbum;
  ListViewWidget({this.futureAblbum});

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  bool loading = false;
  TextEditingController controller = new TextEditingController();
  String filter;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey1 = GlobalKey<RefreshIndicatorState>();

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

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
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
      home: Material(
        child: RefreshIndicator(
          key: refreshKey1,
          onRefresh: refreshList,
          child: Center(
            child: FutureBuilder<CountryList>(
              future: widget.futureAblbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return loading
                      ? Loading()
                      : Container(
                          color: Colors.white,
                          padding: new EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 6,
                              right: SizeConfig.safeBlockHorizontal * 6,
                              top: SizeConfig.safeBlockVertical * 11),
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.only(top: 5),
                              ),
                              SizedBox(
                                height: SizeConfig.safeBlockVertical * 11,
                                child: Text(
                                  "Search",
                                  style: new TextStyle(
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 11,
                                      color: Color.fromRGBO(0, 102, 102, 1)),
                                ),
                              ),
                              Container(
                                padding: new EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal * 5,
                                    right: SizeConfig.safeBlockHorizontal * 5,
                                    top: 0),
                                child: new TextField(
                                  decoration: new InputDecoration(
                                    fillColor: Colors.blue,
                                    labelText: "Search for Country",
                                  ),
                                  controller: controller,
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical * 0.8),
                              ),
                              Expanded(
                                child: new Scaffold(
                                  resizeToAvoidBottomPadding: false,
                                  body: Container(
                                    color: Colors.white,
                                    child: new ListView.builder(
                                      itemCount: snapshot.data.countries == null
                                          ? 0
                                          : snapshot.data.countries.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return filter == null || filter == ""
                                            ? Container(
                                                height: SizeConfig
                                                        .safeBlockVertical *
                                                    15,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CountryScreen(
                                                                futureAblbum: widget
                                                                    .futureAblbum,
                                                                index: index,
                                                              )),
                                                    );
                                                  },
                                                  child: new Card(
                                                    color: Color.fromRGBO(
                                                        0, 122, 122, 1),
                                                    shape:
                                                        new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    15.0),
                                                            side: BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        122,
                                                                        122,
                                                                        1))),
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 6, 5, 0),
                                                    child: ListTile(
                                                        title: Text(
                                                          "${snapshot.data.countries[index].country}",
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Avenir',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: SizeConfig
                                                                      .safeBlockHorizontal *
                                                                  5.5,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        subtitle: Column(
                                                          children: <Widget>[
                                                            Expanded(
                                                                flex: 2,
                                                                child:
                                                                    SizedBox()),
                                                            Expanded(
                                                              flex: 10,
                                                              child: Container(
                                                                width: SizeConfig
                                                                        .safeBlockHorizontal *
                                                                    80,
                                                                child:
                                                                    new RichText(
                                                                  text: new TextSpan(
                                                                      style: new TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.safeBlockHorizontal *
                                                                                2.7,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      children: <TextSpan>[
                                                                        new TextSpan(
                                                                          text:
                                                                              "\nOverall:",
                                                                          style: new TextStyle(
                                                                              fontFamily: 'Avenir',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                                                              color: Colors.white),
                                                                        ),
                                                                        new TextSpan(
                                                                          text:
                                                                              "  Cases:  ${snapshot.data.countries[index].countryCases}  Deaths:  ${snapshot.data.countries[index].countryDeaths}  Recovered:  ${snapshot.data.countries[index].countryRecoveries}",
                                                                          style: new TextStyle(
                                                                              fontFamily: 'Avenir',
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                                                              color: Colors.white),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 1,
                                                                child:
                                                                    SizedBox()),
                                                            Expanded(
                                                              flex: 10,
                                                              child: Container(
                                                                width: SizeConfig
                                                                        .safeBlockHorizontal *
                                                                    80,
                                                                child:
                                                                    new RichText(
                                                                  text: new TextSpan(
                                                                      style: new TextStyle(
                                                                        fontSize:
                                                                            SizeConfig.safeBlockHorizontal *
                                                                                2.7,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      children: <TextSpan>[
                                                                        new TextSpan(
                                                                          text:
                                                                              "\Today:",
                                                                          style: new TextStyle(
                                                                              fontFamily: 'Avenir',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                                                              color: Colors.white),
                                                                        ),
                                                                        new TextSpan(
                                                                          text:
                                                                              "  Cases:  ${snapshot.data.countries[index].countryTodayCases}  Deaths:  ${snapshot.data.countries[index].countryTodayDeaths}   Critical:  ${snapshot.data.countries[index].countryCritical}",
                                                                          style: new TextStyle(
                                                                              fontFamily: 'Avenir',
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: SizeConfig.safeBlockHorizontal * 2.7,
                                                                              color: Colors.white),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 10,
                                                                child:
                                                                    SizedBox()),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : snapshot.data.countries[index]
                                                    .country
                                                    .toLowerCase()
                                                    .contains(
                                                        filter.toLowerCase())
                                                ? Container(
                                                    height: SizeConfig
                                                            .safeBlockVertical *
                                                        15,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CountryScreen(
                                                                    futureAblbum:
                                                                        widget
                                                                            .futureAblbum,
                                                                    index:
                                                                        index,
                                                                  )),
                                                        );
                                                      },
                                                      child: new Card(
                                                        color: Color.fromRGBO(
                                                            0, 122, 122, 1),
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    15.0),
                                                            side: BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        122,
                                                                        122,
                                                                        1))),
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                5, 6, 5, 0),
                                                        child: ListTile(
                                                            title: Text(
                                                              "${snapshot.data.countries[index].country}",
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      'Avenir',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .safeBlockHorizontal *
                                                                          5.5,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            subtitle: Column(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        SizedBox()),
                                                                Expanded(
                                                                  flex: 10,
                                                                  child:
                                                                      Container(
                                                                    width: SizeConfig
                                                                            .safeBlockHorizontal *
                                                                        80,
                                                                    child:
                                                                        new RichText(
                                                                      text: new TextSpan(
                                                                          style: new TextStyle(
                                                                            fontSize:
                                                                                SizeConfig.safeBlockHorizontal * 2.7,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          children: <TextSpan>[
                                                                            new TextSpan(
                                                                              text: "\nOverall:",
                                                                              style: new TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: SizeConfig.safeBlockHorizontal * 2.7, color: Colors.white),
                                                                            ),
                                                                            new TextSpan(
                                                                              text: "  Cases:  ${snapshot.data.countries[index].countryCases}  Deaths:  ${snapshot.data.countries[index].countryDeaths}  Recovered:  ${snapshot.data.countries[index].countryRecoveries}",
                                                                              style: new TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.normal, fontSize: SizeConfig.safeBlockHorizontal * 2.7, color: Colors.white),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        SizedBox()),
                                                                Expanded(
                                                                  flex: 10,
                                                                  child:
                                                                      Container(
                                                                    width: SizeConfig
                                                                            .safeBlockHorizontal *
                                                                        80,
                                                                    child:
                                                                        new RichText(
                                                                      text: new TextSpan(
                                                                          style: new TextStyle(
                                                                            fontSize:
                                                                                SizeConfig.safeBlockHorizontal * 2.7,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          children: <TextSpan>[
                                                                            new TextSpan(
                                                                              text: "\Today:",
                                                                              style: new TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: SizeConfig.safeBlockHorizontal * 2.7, color: Colors.white),
                                                                            ),
                                                                            new TextSpan(
                                                                              text: "  Cases:  ${snapshot.data.countries[index].countryTodayCases}  Deaths:  ${snapshot.data.countries[index].countryTodayDeaths}   Critical:  ${snapshot.data.countries[index].countryCritical}",
                                                                              style: new TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.normal, fontSize: SizeConfig.safeBlockHorizontal * 2.7, color: Colors.white),
                                                                            )
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 10,
                                                                    child:
                                                                        SizedBox()),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                : new Container();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                  //return Text("${snapshot.data.latest}");
                } else if (snapshot.hasError) {
                  print("${snapshot.error}");
                  return RefreshIndicator(
                    key: refreshKey,
                    onRefresh: refreshList,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ListViewError(),
                    ),
                  );
                } else {
                  return Loading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
