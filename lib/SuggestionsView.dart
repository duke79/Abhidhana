import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsView extends StatefulWidget {

  @override
  SuggestionsViewState createState() => new SuggestionsViewState();
}

class SuggestionsViewState extends State<SuggestionsView> {
  String SELECT_100_WORDS = "select * from entries limit 0,100";
  String SELECT_ALL_TABLES = "SELECT name FROM sqlite_master WHERE type=\'table\'";
  String SELECT_WORDS_STARTING_WITH = "select * from entries where UPPER(word) like UPPER(\"INPUT_1%\") limit INPUT_2";

  Set<String> suggestions = new Set<String>();

  addSuggestions(Database db) async {
    String query = SELECT_WORDS_STARTING_WITH.replaceAll(
        new RegExp(r"INPUT_1"), "Bas").replaceAll(new RegExp(r"INPUT_2"), "10");
    debugPrint("Stuggestions: for query ");
    List<Map> list = await db.rawQuery(query);
    debugPrint(list.length.toString());
    debugPrint(" : ");
    setState(() {
      while (list.iterator.moveNext()) {
        Map elem = list.iterator.current;
        if(null != elem) {
          elem.values.forEach((dynamic value) {
            suggestions.add(value.toString());
          });
        }
      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("Loading DB for Stuggestions: ");
    suggestions.add("dummy"); //ToDo: remove this line
    DatabaseServices.loadDictionaryDB().then(
            (Database db) {
          debugPrint("DB loaded, adding suggestions: ");
          addSuggestions(db);
        }
    );
    List<Widget> suggestionsWidgets = new List();
    suggestions.forEach((s) {
      Widget widget = new Container(
        margin: new EdgeInsets.only(bottom: 10.0,),
        child: new Row(
          children: <Widget>[
            new Text(s.toString().toLowerCase(),
              style: new TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      );
      suggestionsWidgets.add(widget);
    });
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: suggestionsWidgets,
    );
  }
}