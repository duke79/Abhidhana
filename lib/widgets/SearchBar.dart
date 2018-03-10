import 'package:flutter/material.dart';
import 'package:myapp/data/Strings.dart';

class SearchViewParams{
  TextEditingController controller;
  FocusNode focusNode;
  var onSubmittedCB;
  var onChangedCB;
  TextStyle style;
  InputDecoration decoration;

  SearchViewParams(this.controller, {
    this.focusNode,
    this.onSubmittedCB,
    this.onChangedCB,
    this.style,
    this.decoration,
  });
}

class SearchBar extends StatefulWidget {
  SearchViewParams params;

  SearchBar(this.params){
    debugPrint(Strings.trace_searchView);
  }

  @override
  SearchViewState createState() =>
      new SearchViewState(this.params);
}

class SearchViewState extends State<SearchBar> {
  SearchViewParams params;

  SearchViewState(this.params);

  @override
  void didUpdateWidget(SearchBar oldWidget) {
  }

  @override
  Widget build(BuildContext context) {
    Widget ret = new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: params.controller,
            focusNode: params.focusNode,
            onSubmitted: params.onSubmittedCB,
            onChanged: params.onChangedCB,
            style: params.style,
            decoration:params.decoration,
          ),
          new FlatButton(
              onPressed: () => params.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
    return ret;
  }
}