import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/model/MyLocale.dart';
import 'package:myapp/routes/MyCustomRoute.dart';
import 'package:myapp/routes/Home.dart';
import 'package:myapp/routes/Search.dart';

void main() {
  //Run app
  runApp(myApp());
  //Cache heavy data
  DatabaseServices.trie;
}

Widget myApp(){
  return new MaterialApp(
    title: 'Vilokan Dictionary',
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
      switch (settings.name) {
        case '/' :
          return new MyCustomRoute(
            builder: (context) =>
            new Home(title: MyLocale
                .of(context)
                .title /*'Flutter Demo Home Page'*/),
            settings: settings,
          );
        case '/search':
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
      }
    },
  );
}