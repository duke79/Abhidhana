import 'package:flutter/material.dart';
import 'package:myapp/Screen.dart';

class SuggestionsView extends StatefulWidget {

  @override
  SuggestionsViewState createState() => new SuggestionsViewState();
}

class SuggestionsViewState extends State<SuggestionsView> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Fellow",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Felix",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}