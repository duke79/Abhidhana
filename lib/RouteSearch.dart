import 'package:flutter/material.dart';
import 'package:myapp/Screen.dart';
import 'package:myapp/SearchView.dart';
import 'package:myapp/SuggestionsView.dart';

class RouteSearch extends StatelessWidget {
  FocusNode focusNode;

  RouteSearch({Key key, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen.updateScreen(context);
    final TextEditingController _controller = new TextEditingController();

    Widget ret = new Scaffold(
      /*appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        */ /*title: new Text("Search"),*/ /*
      ),*/
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SearchView
            new Container(
              margin: new EdgeInsets.only(top: Screen.width / 20,),
              width: Screen.width / Screen.GOLDEN_RATIO,
              child: new Hero(
                tag: "SearchViewTag",
                child: new SearchView(
                  new SearchViewParams(
                    _controller,
                    focusNode: focusNode,
                    decoration: new InputDecoration(
                      labelStyle: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            //SuggestionsView
            new Container(
                margin: new EdgeInsets.only(top: 20.0),
                width: Screen.width / Screen.GOLDEN_RATIO,
                child: new Center(
                  child: new SuggestionsView(),
                )
            ),
          ],
        ),
      ),
    );
    return ret;
  }
}