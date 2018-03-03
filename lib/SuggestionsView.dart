import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsView extends StatefulWidget {
  SuggestionsViewState _state;

  suggestFor(String prefix) {
    if (null != _state)
      _state.suggestFor(prefix);
  }

  @override
  SuggestionsViewState createState() {
    _state = new SuggestionsViewState();
    return _state;
  }
}

class SuggestionsViewState extends State<SuggestionsView> {
  String SELECT_100_WORDS = "select * from entries limit 0,100";
  String SELECT_ALL_TABLES = "SELECT name FROM sqlite_master WHERE type=\'table\'";
  String SELECT_WORDS_STARTING_WITH = "select * from entries where UPPER(word) like UPPER(\"INPUT_1%\") limit INPUT_2";

  Set<String> suggestions = new Set<String>();

  @override
  Widget build(BuildContext context) {
    debugPrint("Loading DB for Stuggestions: ");
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

  void suggestFor(String prefix) {
    DatabaseServices.loadDictionaryDB().then(
            (Database db) async {
          debugPrint("DB loaded, adding suggestions: ");

          String query = SELECT_WORDS_STARTING_WITH.replaceAll(
              new RegExp(r"INPUT_1"), prefix).replaceAll(
              new RegExp(r"INPUT_2"), "10");
          debugPrint("Stuggestions: for query ");
          List<Map> list = await db.rawQuery(query);
          debugPrint(list.length.toString());
          debugPrint(" : ");
          setState(() {
            list.forEach((elem) {
              if (null != elem) {
                suggestions.add(elem["word"].toString());
              }
            });
          });
        }
    );
  }
}