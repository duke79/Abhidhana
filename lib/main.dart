import 'package:flutter/material.dart';
import 'package:myapp/MyCustomRoute.dart';
import 'package:myapp/RouteHome.dart';
import 'package:myapp/RouteSearch.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*routes: <String, WidgetBuilder>{
        "/": (_) => new RouteHome(title: 'Flutter Demo Home Page'),
        "/search": (_) => new RouteSearch(),
      },*/
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/' :
            return new MyCustomRoute(
              builder: (_) => new RouteHome(title: 'Flutter Demo Home Page'),
              settings: settings,
            );
          case '/search':
            bool firstBuild = true;
            FocusNode focusNode =  new FocusNode();
            return new MyCustomRoute(
              builder: (BuildContext context) {
                Widget ret = new RouteSearch(focusNode: focusNode,);
                if(true == firstBuild) {
                  FocusScope.of(context).requestFocus(focusNode);
                  firstBuild = false;
                }
                return ret;
              },
              settings: settings,
            );
        }
      },
    );
  }
}