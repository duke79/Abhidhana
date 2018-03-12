import 'package:flutter/material.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/TitleBar.dart';

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
                child: new Definitions(word: widget.word),
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