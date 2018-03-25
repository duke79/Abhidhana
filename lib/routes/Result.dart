import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/Parallax.dart';
import 'package:myapp/widgets/TitleBar.dart';

class ResultState extends State<Result> {
  var _controller = new PageController();

  @override
  void initState() {
  }


  @override
  Widget build(BuildContext context) {
    /*Hide StatusBar (top) & Android buttons (bottom)
  https://stackoverflow.com/a/43879271/9404410*/
    SystemChrome.setEnabledSystemUIOverlays([]);

    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: new Parallax(
              childParallax: new Container(
                height: 400.0,
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
              childBody: new Column(
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new TitleBar(title: widget.word),
                        ),
                      ],
                    ),
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
        ),
      ),
    );
  }
}

//This route shows the word definition.
//ToDo:<Enhancement> Scroll for the content, absolutely required once the tile reaches the top.
//ToDo:<Issue> Touch disambiguation? for the above mentioned scroll, since drag must work even
// if the title hasn't reached the top.
class Result extends StatefulWidget {
  Result({Key key, this.word}) : super(key: key);

  final String word;

  @override
  ResultState createState() => new ResultState();
}