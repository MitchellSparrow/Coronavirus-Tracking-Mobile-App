import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';

///The following widget is used as a popup on the home page
///for a disclaimer. This is important as it notifies the user
///that the information provided may be incorrect as a specific
///point in time

class DisclaimerBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Text(
            "DISCLAIMER:",
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 8,
                color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: Text(
              '''The following app connects to the public REST API:https://corona.lmao.ninja/ 
              Which collects data from: https://www.worldometers.info/coronavirus/\n\n
              This app is therefore a graphical represention of the data and does not create the data itself. 
              The statistics provided by the API seem accurate, however may be incorrect at a specific point in time.\n\n
              The goal of the app is to provide AWARENESS and INFORMATION of the spreading Coronavirus, 
              NOT to spread Fake News.''',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                  color: Colors.grey[800]),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(),
        ),
        ButtonTheme(
          minWidth: 180.0,
          height: 50.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
              side: BorderSide(color: Color.fromRGBO(19, 41, 75, 1))),
          child: RaisedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text(
              "CLOSE",
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
            color: Color.fromRGBO(0, 102, 102, 1),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}
