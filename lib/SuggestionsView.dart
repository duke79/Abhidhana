import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsView extends StatefulWidget {
  SuggestionsViewState _state;
  String _prefix;


  String get prefix => _prefix;

  set prefix(String value) {
    _prefix = value;
    if (null != _state)
      _state.prefix = prefix;
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
  String _prefix;
  GlobalKey<AnimatedListState> _keyAnimatedList = new GlobalKey<
      AnimatedListState>();


  String get prefix => _prefix;

  set prefix(String value) {
    _prefix = value;

    DatabaseServices.loadDictionaryDB().then(
            (Database db) async {
          debugPrint("DB loaded, adding suggestions: ");

          String query = SELECT_WORDS_STARTING_WITH.replaceAll(
              new RegExp(r"INPUT_1"), prefix).replaceAll(
              new RegExp(r"INPUT_2"), "10");
          debugPrint("Stuggestions: for query ");

          if (_prefix != value)
            return;
          if (_prefix.length < 1) {
            suggestions.clear();
            return;
          }
          List<Map> list = await db.rawQuery(query);
          if (_prefix != value)
            return;
          if (_prefix.length < 1) {
            suggestions.clear();
            return;
          }

          debugPrint(list.length.toString());
          debugPrint(" : ");
          suggestions.clear();

          int i = 0;
          Map elem = list.elementAt(i);
          while (elem != null && i < list.length) {
            /*sleep(const Duration(milliseconds: 1000));*/
            if (null != elem) {
              AnimatedListState listState = _keyAnimatedList.currentState;
              if (null != listState) {
                listState.insertItem(i);
                suggestions.add(elem["word"].toString());
              }
            }
            elem = list.elementAt(i++);
          };
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Loading DB for Stuggestions: ");
    return new Expanded(
        child: new AnimatedList(
            key: _keyAnimatedList,
            itemBuilder: (BuildContext context, int index,
                Animation<double> animation) {
              if (index >= suggestions.length)
                return null;
              return new Row(
                children: <Widget>[
                  new Text(
                    suggestions.elementAt(index).toString().toLowerCase(),
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ],
              );
            }
        ));
  }
}