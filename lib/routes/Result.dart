import 'package:flutter/material.dart';
import 'package:myapp/model/MyLocale.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/widgets/BatteryLevel.dart';
import 'package:myapp/widgets/ChargingStatus.dart';
import 'package:myapp/widgets/MyDrawer.dart';
import 'package:myapp/model/Screen.dart';
import 'package:myapp/widgets/SearchBar.dart';

class ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        margin: const EdgeInsets.only(top: 200.0),
        alignment: const AlignmentDirectional(1.0, 1.0),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                  new AnimatedAlign(
                    alignment: Alignment.center,
                    duration: const Duration(seconds: 1),
                    child: new Text(
                      widget.word,
                      textScaleFactor: 3.0,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class Result extends StatefulWidget {
  Result({Key key, this.word}) : super(key: key);

  final String word;

  @override
  ResultState createState() => new ResultState();
}