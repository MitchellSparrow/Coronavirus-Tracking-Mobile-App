import 'package:coronatracker/models/size_config.dart';
import 'package:flutter/material.dart';

///The following class describes a widget made for a
///bullet point. this is just the circle of the point
///and not the whole point including text.

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return new Container(
      height: SizeConfig.safeBlockHorizontal * 5,
      width: SizeConfig.safeBlockHorizontal * 5,
      decoration: new BoxDecoration(
        color: Color.fromRGBO(0, 102, 102, 1),
        shape: BoxShape.circle,
      ),
    );
  }
}
