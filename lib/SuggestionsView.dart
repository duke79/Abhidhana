import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsView extends StatefulWidget {

  @override
  SuggestionsViewState createState() => new SuggestionsViewState();
}

class SuggestionsViewState extends State<SuggestionsView> {

  addSuggestions(Database db) async{
    List<Map> list = await db.rawQuery('SELECT word FROM entries where UPPER(word) like UPPER(\"hello\")');
    print(list);
  }
  
  @override
  Widget build(BuildContext context) {
    DatabaseServices.loadDictionaryDB().then(
      (Database db){
        addSuggestions(db);
      }
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Fellow",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Felix",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}