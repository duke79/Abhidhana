import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/data/Strings.dart';

class Suggestions extends State<SuggestionsView> {

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new AnimatedList(
          key: _keyAnimatedList,
          itemBuilder: _buildItem,
        ));
  }

  /*Methods*/
  void _updateSuggestions() async{
    DatabaseServices.trie.then((trie){
      List<String> suggestions = trie.suggestions(prefix,length: 5);
      int i = 0;
      for(i=0;(i < suggestions.length) && (i<10);i++) {
        _suggestions.add(suggestions.elementAt(i));
        _keyAnimatedList.currentState.setState(() {//Todo: Does setState has any impact?
          _keyAnimatedList.currentState.insertItem(i);
        });
      }
    });
  }

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation) {
    if (index >= _suggestions.length)
      return null;
    return new Row(
      children: <Widget>[
        new Text(
          _suggestions.elementAt(index).toString().toLowerCase(),
          style: new TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  /*const fields*/


  /*Local fields*/
  Set<String> _suggestions = new Set<String>();
  String _prefix;
  static final GlobalKey<AnimatedListState> _keyAnimatedList = new GlobalKey<
      AnimatedListState>();

  String get _query {
    return Strings.SQL_SELECT_WORDS_STARTING_WITH.replaceAll(
        new RegExp(Strings.SQL_VAR_INPUT1), prefix).replaceAll(
        new RegExp(Strings.SQL_VAR_INPUT2), Strings.SQL_VAR_LIMIT);
  }

  /*Public fields*/
  String get prefix => _prefix;

  set prefix(String value) {
    _prefix = value;
    if (null != _keyAnimatedList.currentState) {
      for(int i=_suggestions.length-1;i>=0;i--){
        _keyAnimatedList.currentState.removeItem(i,(BuildContext context, Animation<double> animation) {
          new Text(Strings.str_gone);
        });
      }
    }
    _suggestions.clear();
    if (_prefix.length < 1) return;

    //_updateSuggestions();
    _updateSuggestions();
  }
}

class SuggestionsView extends StatefulWidget {
  SuggestionsView({Key key}) :super(key: key);

  @override
  Suggestions createState() => new Suggestions();
}