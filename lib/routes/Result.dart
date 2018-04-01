import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widgets/Definitions.dart';
import 'package:myapp/widgets/Parallax.dart';
import 'package:myapp/widgets/TitleBarWithFAB.dart';
import 'package:myapp/widgets/WordExamples.dart';
import 'package:tts/tts.dart';

class ResultState extends State<Result> {

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
      // May use SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]), but it didn't work the last time. :(
      resizeToAvoidBottomPadding: false,
//TODO(Explore): Re-use widget in a tree?
//      bottomNavigationBar: new BottomAppBar(
//        child: _titleKey.currentContext.,
//      ),
      body: new Parallax(
        parallaxRatio: 0.5,
        bottomWidget: _titleKey,
        childParallax: new WordExamples(widget.word),
        childBody: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              //TODO(Issue): FAB is half visible if definition overflows. (Try searching 'cool' to see the behavior)
              new TitleBarWithFAB(
                key: _titleKey,
                title: widget.word,
                onFABPressed: _onFABPressed,
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

  /*Future */
  _onFABPressed() /*async */ {
/*    var languages = await Tts.getAvailableLanguages();*/
    Tts.setLanguage("en-US");
/*    for(var language in languages){
      Tts.setLanguage(language);
    }*/
    Tts.speak(widget.word);
  }
}

//This route shows the word definition.
//TODO(Enhancement): Scroll for the content, absolutely required once the tile reaches the top.
//TODO(Issue): Touch disambiguation? for the above mentioned scroll, since drag must work even if the title hasn't reached the top.
class Result extends StatefulWidget {
  Result({Key key, this.word}) : super(key: key);

  final String word;

  @override
  ResultState createState() => new ResultState();
}