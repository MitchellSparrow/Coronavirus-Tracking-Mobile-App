import 'package:coronatracker/models/bullet.dart';
import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 9,
          left: SizeConfig.safeBlockHorizontal * 7,
          right: SizeConfig.safeBlockHorizontal * 7,
          bottom: SizeConfig.safeBlockVertical * 3),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                "How to prevent the spreading of the disease:",
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 8.5,
                    color: Color.fromRGBO(0, 102, 102, 1)),
              ),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 12,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Wash your hands for at least 20 seconds',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Try not to touch your face',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Keep your distance from others',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Do not shake hands whith others',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Only go to public places when absolutly neccessary',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Work from home',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  child: ListTile(
                      leading: new MyBullet(),
                      title: Text(
                        'Keep hand sanitizor with you at all times',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                            color: Colors.black),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
