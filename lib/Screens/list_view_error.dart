import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';

class ListViewError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: MediaQuery.of(context).size.height - 50,
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
                  fontSize: SizeConfig.safeBlockHorizontal * 11,
                  color: Color.fromRGBO(0, 102, 102, 1)),
            ),
          ),
          Container(
            padding: new EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal * 5,
                right: SizeConfig.safeBlockHorizontal * 5,
                top: 0),
          ),
          new Padding(
            padding: new EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 1,
              right: SizeConfig.safeBlockHorizontal * 6,
              left: SizeConfig.safeBlockHorizontal * 6,
            ),
          ),
          Expanded(
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
