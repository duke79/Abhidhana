import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/TitleBar.dart';

class ResultState extends State<Result> with SingleTickerProviderStateMixin {
  var _controller = new PageController();

  AnimationController _animationController;
  Animation<num> _animation;

  @override
  void initState() {
    _animationController = new AnimationController(
        duration: const Duration(seconds: 20),
        vsync: this,
    );
    _animation =
        new Tween(begin: 600.0, end: 0.0).animate(_animationController);
    _animation.addListener(() {
      setState(() => null);
    });
    _animationController.animateWith(new SpringSimulation(new SpringDescription.withDampingRatio(
      mass: 2.0,
      stiffness: 2.0,
      ratio: 1.0
    ),0.0,1.0,1.0));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    /*Hide StatusBar (top) & Android buttons (bottom)
  https://stackoverflow.com/a/43879271/9404410*/
    SystemChrome.setEnabledSystemUIOverlays([]);

    return new Scaffold(
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(
                      top: _animation.value.toDouble()/2,
                    ),
                    //Because PageView doesn't work under flex widgets (Column,Row)
                    height: _animation.value.toDouble()/2+200,
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
                  new Container(
                    margin: new EdgeInsets.only(
                      top: (1.5*_animation.value.toDouble())+200.0,
                    ),
                    child: new Column(
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
                ],
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