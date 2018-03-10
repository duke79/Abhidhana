import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/routes/MyCustomRoute.dart';
import 'package:myapp/routes/Home.dart';
import 'package:myapp/routes/Search.dart';

void main() {
  //Run app
  runApp(new MyApp());
  //Cache heavy data
  DatabaseServices.trie;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Vilokan Dictionary',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/' :
            return new MyCustomRoute(
              builder: (_) => new Home(title: 'Flutter Demo Home Page'),
              settings: settings,
            );
          case '/search':
            bool firstBuild = true;
            FocusNode focusNode =  new FocusNode();
            return new MyCustomRoute(
              builder: (BuildContext context) {
                Widget ret = new Search(focusNode: focusNode,);
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