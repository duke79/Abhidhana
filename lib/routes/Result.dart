import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/model/MyLocale.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/widgets/BatteryLevel.dart';
import 'package:myapp/widgets/ChargingStatus.dart';
import 'package:myapp/widgets/MyDrawer.dart';
import 'package:myapp/model/Screen.dart';
import 'package:myapp/widgets/SearchBar.dart';

class ResultState extends State<Result> {
  String _definition = "Loading...";

  @override
  Widget build(BuildContext context) {
    _loadDefinition();
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
              new AnimatedAlign(
                alignment: Alignment.center,
                duration: const Duration(seconds: 1),
                child: new Text(
                  _definition,
                  textScaleFactor: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Methods*/
  Future _loadDefinition() async {
    debugPrint("Loading DB for Stuggestions: ");

    List<Map> list = await (await DatabaseServices.db).rawQuery(_query);

    Map elem = list.elementAt(0);
    if (null != elem) {
      setState(() {
        _definition = elem["definition"].toString().replaceAll("\n", "");
      });
    }
  }

  String get _query {
    return Strings.SQL_SELECT_WORD_DEFINITION.replaceAll(
        new RegExp(Strings.SQL_VAR_INPUT1), widget.word
    );
  }
}

class Result extends StatefulWidget {
  Result({Key key, this.word}) : super(key: key);

  final String word;

  @override
  ResultState createState() => new ResultState();
}