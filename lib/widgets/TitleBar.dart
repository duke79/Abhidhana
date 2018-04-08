import 'package:flutter/material.dart';


class TitleBar extends StatelessWidget {
  String title = "";

  TitleBar({
    this.title,
    Key key,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            decoration: new ShapeDecoration(
              //color: Colors.blue[500],
              gradient: new LinearGradient(
                colors: <Color>[
                  Colors.blue[900],
                  Colors.blue[500]
                ],
                begin: Alignment.centerLeft,
                end: Alignment.center,
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(
                  new Radius.circular(10.0),
                ),
              ),
              shadows: <BoxShadow>[
                new BoxShadow(
                  color: const Color(0xcc000000),
                  offset: new Offset(0.0, 2.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              left: 50.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: new Text(
              this.title,
              style: const TextStyle(color: Colors.white),
              textScaleFactor: 3.0,
            ),
          ),
        ),
      ],
    );
  }
}