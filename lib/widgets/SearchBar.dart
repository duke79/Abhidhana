import 'package:flutter/material.dart';
import 'package:myapp/data/Strings.dart';

class SearchViewParams {
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
  final SearchViewParams params;

  SearchBar(this.params) {
    debugPrint(Strings.trace_searchView);
  }

  @override
  SearchViewState createState() => new SearchViewState();
}

class SearchViewState extends State<SearchBar> {

  SearchViewState();

  @override
  Widget build(BuildContext context) {
    Widget ret = new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: widget.params.controller,
            focusNode: widget.params.focusNode,
            onSubmitted: widget.params.onSubmittedCB,
            onChanged: widget.params.onChangedCB,
            style: widget.params.style,
            decoration: widget.params.decoration,
          ),
          new FlatButton(
              onPressed: () => widget.params.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
    return ret;
  }
}