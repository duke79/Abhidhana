import 'package:flutter/material.dart';
import 'package:myapp/SearchView.dart';

class RouteSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mq = MediaQuery.of(context);
    final TextEditingController _controller = new TextEditingController();

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Search"),
      ),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
                width: mq.size.width / 1.6,
                child: new SearchView(_controller),
            ),
          ],
        ),
      ),
    );
  }
}