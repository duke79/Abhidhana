import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/widgets/TitleBar.dart';

class ResultState extends State<Result> {
  List<String> _definitions = new List();

  @override
  void initState() {
    _loadDefinitions();
    super.initState();
  }

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
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new TitleBar(title: widget.word),
                  ),
                ],
              ),
              new Container(
                margin: new EdgeInsets.only(
                  top: 20.0,
                  left: 100.0,
                ),
                child: _definitions.length < 1 ? new CircularProgressIndicator()
                    : new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _definitions.map((String definition) {
                    return new Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: new Text(
                        definition,
                        textScaleFactor: 2.0,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Methods*/
  Future _loadDefinitions() async {
    debugPrint("Loading DB for Stuggestions: ");

    List<Map> list = await (await DatabaseServices.db).rawQuery(_query);

    _definitions.clear();
    list.forEach((elem) {
      if (null != elem) {
        setState(() {
          String definition = elem["definition"].toString().replaceAll(
              "\n", "");
          _definitions.add(definition);
        });
      }
    });
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