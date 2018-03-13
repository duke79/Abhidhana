import 'package:flutter/material.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/TitleBar.dart';

class ResultState extends State<Result> {
  var _controller = new PageController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                //Because PageView doesn't work under flex widgets (Column,Row)
                height: 200.0,
                child: new PageView.builder(
                  physics: new AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: new FlutterLogo(colors: Colors.blue,),
                    );
                  },
                ),
              ),
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