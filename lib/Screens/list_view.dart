import 'dart:async';
import 'package:coronatracker/models/album.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatefulWidget {
  Future<Album> futureAblbum;
  ListViewWidget({this.futureAblbum});

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  TextEditingController controller = new TextEditingController();
  String filter;

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
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Album>(
            future: widget.futureAblbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  padding: new EdgeInsets.only(left: 20, right: 20, top: 80),
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
                        padding:
                            new EdgeInsets.only(left: 20, right: 20, top: 0),
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
                          body: new ListView.builder(
                            itemCount: snapshot.data.clocations == null
                                ? 0
                                : snapshot.data.clocations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return filter == null || filter == ""
                                  ? new Card(
                                      color: Color.fromRGBO(0, 122, 122, 1),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 122, 122, 1))),
                                      margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
                                      child: ListTile(
                                        title: Text(
                                          "${snapshot.data.clocations[index]["country"]} ${snapshot.data.clocations[index]["province"]}",
                                          style: new TextStyle(
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          "Confirmed:  ${snapshot.data.clocations[index]["latest"]}  Deaths:  ${snapshot.data.dlocations[index]["latest"]}  Recovered:  ${snapshot.data.rlocations[index]["latest"]}",
                                          style: new TextStyle(
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : snapshot.data.clocations[index]["country"]
                                          .contains(filter)
                                      ? new Card(
                                          color: Color.fromRGBO(0, 102, 102, 1),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                              side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 122, 122, 1))),
                                          margin:
                                              EdgeInsets.fromLTRB(5, 6, 5, 0),
                                          child: ListTile(
                                            title: Text(
                                              "${snapshot.data.clocations[index]["country"]} ${snapshot.data.clocations[index]["province"]}",
                                              style: new TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "Confirmed:  ${snapshot.data.clocations[index]["latest"]}  Deaths:  ${snapshot.data.dlocations[index]["latest"]}  Recovered:  ${snapshot.data.rlocations[index]["latest"]}",
                                              style: new TextStyle(
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Colors.white),
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
