import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/model/MyLocale.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/routes/MyCustomRoute.dart';
import 'package:myapp/routes/Home.dart';
import 'package:myapp/routes/Result.dart';
import 'package:myapp/routes/Search.dart';

void main() {
  /*Hide StatusBar (top) & Android buttons (bottom)
  https://stackoverflow.com/a/43879271/9404410*/
  SystemChrome.setEnabledSystemUIOverlays([]);
  //Run app
  runApp(myApp());
  //Cache heavy data
  DatabaseServices.trie;
}

Widget myApp() {
  return new MaterialApp(
    title: Strings.app_title,
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    supportedLocales: [
      const Locale('en', ''), //English
      const Locale('es', ''), //Spanish
    ],
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
/*        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,*/
      DefaultMaterialLocalizations.delegate,
      const MyLocalizationDelegate(),
    ],
    onGenerateRoute: (RouteSettings settings) {
      var path = settings.name.split("/");
      switch ("/"+path[1]) {
        case Strings.route_home :
          return new MyCustomRoute(
            builder: (context) =>
            new Home(title: MyLocale
                .of(context)
                .value(Strings.localeKey_title)),
            settings: settings,
          );
        case Strings.route_search:
          bool firstBuild = true;
          FocusNode focusNode = new FocusNode();
          return new MyCustomRoute(
            builder: (BuildContext context) {
              Widget ret = new Search(focusNode: focusNode,);
              if (true == firstBuild) {
                FocusScope.of(context).requestFocus(focusNode);
                firstBuild = false;
              }
              return ret;
            },
            settings: settings,
          );
        case Strings.route_result :
          return new MyCustomRoute(
            builder: (context) =>
            new Result(word: path[2]),
            settings: settings,
          );
      }
    },
  );
}