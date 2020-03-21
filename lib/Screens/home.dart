import 'package:coronatracker/Screens/home_page.dart';
import 'package:coronatracker/Screens/info.dart';
import 'package:coronatracker/Screens/list_view.dart';
import 'package:coronatracker/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

import 'country_screen.dart';

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://coronavirus-tracker-api.herokuapp.com/all');
  print(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonResponse = convert.jsonDecode(response.body);
    var latestData = jsonResponse['latest']['confirmed'];
    var locations = jsonResponse['locations'];
    print("Data Loaded Successfully");
    print(latestData);

    return Album.fromJson(convert.jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to load album');
  }
}

Future<TotalsAlbum> fetchTotalsAlbum() async {
  final response = await http.get('https://corona.lmao.ninja/all');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("Totals Data Loaded Successfully");
    return TotalsAlbum.fromJson(convert.jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to load album');
  }
}

Future<CountryList> fetchCountryAlbum() async {
  final response = await http.get('https://corona.lmao.ninja/countries');
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  Future<Album> futureAlbum;
  Future<TotalsAlbum> totalsAlbum;
  Future<CountryList> countryAlbum;
  TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    totalsAlbum = fetchTotalsAlbum();
    countryAlbum = fetchCountryAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(0, 102, 102, 1),
      ),
      color: Colors.yellow,
      home: DefaultTabController(
        length: 3,
        child: new Scaffold(
          extendBodyBehindAppBar: true,
          body: TabBarView(
            children: [
              new Container(
                color: Colors.white,
                child: HomePageWidget(
                  futureAblbum: totalsAlbum,
                ),
              ),
              new Container(
                //child: Text(countryAlbum.countryCases),
                child: ListViewWidget(
                  futureAblbum: countryAlbum,
                ),
              ),
              new Container(
                //child: Text(countryAlbum.countryCases),
                child: InfoScreen(),
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.home),
                ),
                Tab(
                  icon: new Icon(Icons.search),
                ),
                Tab(
                  icon: new Icon(Icons.info),
                ),
              ],
              labelColor: Color.fromRGBO(0, 102, 102, 1),
              unselectedLabelColor: Color.fromRGBO(0, 204, 204, 1),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Color.fromRGBO(0, 102, 102, 1)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
