import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/Parallax.dart';
import 'package:myapp/widgets/TitleBar.dart';

class ResultState extends State<Result> {
  var _controller = new PageController();

  final GlobalKey _titleKey = new GlobalKey();

  @override
  void initState() {
  }


  @override
  Widget build(BuildContext context) {
    /*Hide StatusBar (top) & Android buttons (bottom)
  https://stackoverflow.com/a/43879271/9404410*/
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return new Scaffold(
      //TODO(Issue): Bottom navigation must be visible
      // May use SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]), but it didn't work the last time. :(
      resizeToAvoidBottomPadding: false,
//TODO(Explore): Re-use widget in a tree?
//      bottomNavigationBar: new BottomAppBar(
//        child: _titleKey.currentContext.,
//      ),
      body: new Parallax(
        parallaxRatio: 0.5,
        bottomWidget: _titleKey,
        childParallax: new PageView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _controller,
          itemBuilder: (context, index) {
            return new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new FlutterLogo(colors: Colors.blue,),
            );
          },
        ),
        childBody: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new TitleBar(
                key: _titleKey,
                title: widget.word,
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

//This route shows the word definition.
//TODO(Enhancement): Scroll for the content, absolutely required once the tile reaches the top.
//TODO(Issue): Touch disambiguation? for the above mentioned scroll, since drag must work even
// if the title hasn't reached the top.
class Result extends StatefulWidget {
  Result({Key key, this.word}) : super(key: key);

  final String word;

  @override
  ResultState createState() => new ResultState();
}