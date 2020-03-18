import 'dart:async';
import 'package:coronatracker/models/album.dart';
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
    return MaterialApp(
      title: 'Corona Statistics',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 102, 102, 1),
        accentColor: Color.fromRGBO(0, 204, 204, 1),
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
                          padding:
                              new EdgeInsets.only(left: 20, right: 20, top: 80),
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.only(top: 5),
                              ),
                              SizedBox(
                                height: 70,
                                child: Text(
                                  "Search",
                                  style: new TextStyle(
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                      color: Color.fromRGBO(0, 102, 102, 1)),
                                ),
                              ),
                              Container(
                                padding: new EdgeInsets.only(
                                    left: 20, right: 20, top: 0),
                                child: new TextField(
                                  decoration: new InputDecoration(
                                    fillColor: Colors.blue,
                                    labelText: "Search for Country",
                                  ),
                                  controller: controller,
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.only(top: 10),
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
                                                height: 90,
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
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      "\nOverall:   Cases:  ${snapshot.data.countries[index].countryCases}  Deaths:  ${snapshot.data.countries[index].countryDeaths}  Recovered:  ${snapshot.data.countries[index].countryRecoveries}\nToday:     Cases:  ${snapshot.data.countries[index].countryTodayCases}  Deaths:  ${snapshot.data.countries[index].countryTodayDeaths}   Critical:  ${snapshot.data.countries[index].countryCritical}",
                                                      style: new TextStyle(
                                                          fontFamily: 'Avenir',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 11,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : snapshot.data.countries[index]
                                                    .country
                                                    .toLowerCase()
                                                    .contains(
                                                        filter.toLowerCase())
                                                ? Container(
                                                    height: 90,
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
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        subtitle: Text(
                                                          "\nOverall:   Cases:  ${snapshot.data.countries[index].countryCases}  Deaths:  ${snapshot.data.countries[index].countryDeaths}  Recovered:  ${snapshot.data.countries[index].countryRecoveries}\nToday:     Cases:  ${snapshot.data.countries[index].countryTodayCases}  Deaths:  ${snapshot.data.countries[index].countryTodayDeaths}   Critical:  ${snapshot.data.countries[index].countryCritical}",
                                                          style: new TextStyle(
                                                              fontFamily:
                                                                  'Avenir',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.white),
                                                        ),
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
                      child: Container(
                        height: MediaQuery.of(context).size.height - 50,
                        color: Colors.white,
                        padding:
                            new EdgeInsets.only(left: 20, right: 20, top: 80),
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.only(top: 5),
                            ),
                            SizedBox(
                              height: 70,
                              child: Text(
                                "Search",
                                style: new TextStyle(
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                    color: Color.fromRGBO(0, 102, 102, 1)),
                              ),
                            ),
                            Container(
                              padding: new EdgeInsets.only(
                                  left: 20, right: 20, top: 0),
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(top: 10),
                            ),
                            Expanded(
                              child: new Scaffold(
                                body: Container(
                                  padding: new EdgeInsets.only(
                                      left: 20, right: 20, top: 30),
                                  child: Center(
                                    child: Text(
                                      "Error while loading data\n\n\nPlease try again",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
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
