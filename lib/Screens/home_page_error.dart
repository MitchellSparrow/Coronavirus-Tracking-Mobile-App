import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';

class HomePageError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      padding: EdgeInsets.only(top: 0, left: 0, right: 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
              height: SizeConfig.safeBlockVertical * 35,
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
                    border: Border.all(color: Colors.white, width: 0)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 12,
                      child: Text(
                        "COVID-19",
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 11,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 58,
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 14,
                          ),
                          child: Text(
                            "Cases:",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            "---",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 58,
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 14,
                          ),
                          child: Text(
                            "Deaths:",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            "---",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 58,
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 14,
                          ),
                          child: Text(
                            "Recovered:",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            "---",
                            style: new TextStyle(
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6.5,
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
            flex: 20,
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
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
