import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://coronavirus-tracker-api.herokuapp.com/confirmed');
  print(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonResponse = convert.jsonDecode(response.body);
    var latestData = jsonResponse['latest'];
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

class Album {
  final int latest;
  final String last_updated;
  final List locations;

  Album({this.latest, this.last_updated, this.locations});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      latest: json['latest'],
      last_updated: json['last_updated'],
      locations: json['locations'],
    );
  }
}

class ListViewWidget extends StatefulWidget {
  ListViewWidget({Key key}) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Future<Album> futureAlbum;
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid-19 Statistics'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data.locations);
                return Container(
                  padding: new EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(top: 10),
                      ),
                      new TextField(
                        decoration: new InputDecoration(
                            labelText: "Search for Country"),
                        controller: controller,
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 10),
                      ),
                      Expanded(
                        child: new Scaffold(
                          body: new ListView.builder(
                            itemCount: snapshot.data.locations == null
                                ? 0
                                : snapshot.data.locations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return filter == null || filter == ""
                                  ? new Card(
                                      color: Colors.white,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                                      child: ListTile(
                                        title: Text(
                                          "${snapshot.data.locations[index]["country"]} ${snapshot.data.locations[index]["province"]}",
                                          style: new TextStyle(
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          "Confirmed Cases:  ${snapshot.data.locations[index]["latest"]}",
                                          style: new TextStyle(
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : snapshot.data.locations[index]["country"]
                                          .contains(filter)
                                      ? new Card(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                              side: BorderSide(
                                                  color: Colors.white)),
                                          margin:
                                              EdgeInsets.fromLTRB(5, 6, 5, 0),
                                          child: ListTile(
                                            title: Text(
                                              "${snapshot.data.locations[index]["country"]} ${snapshot.data.locations[index]["province"]}",
                                              style: new TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              "Confirmed Cases:  ${snapshot.data.locations[index]["latest"]}",
                                              style: new TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      : new Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                //return Text("${snapshot.data.latest}");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
