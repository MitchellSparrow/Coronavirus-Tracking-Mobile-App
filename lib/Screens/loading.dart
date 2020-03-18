import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,
            Colors.white,
          ])),
      child: Center(
        child: SpinKitWanderingCubes(
          color: Color.fromRGBO(0, 102, 102, 1),
          size: 60,
        ),
      ),
    );
  }
}
