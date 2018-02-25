import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  TextEditingController controller;
  bool focus;

  SearchView(this.controller, {this.focus = false});

  @override
  SearchViewState createState() =>
      new SearchViewState(this.controller, focus: this.focus);
}

class SearchViewState extends State<SearchView> {
  TextEditingController controller;
  bool focus = false;
  FocusNode focusNode = new FocusNode();

  SearchViewState(this.controller, {this.focus});

  @override
  void didUpdateWidget(SearchView oldWidget) {
    if (true == this.focus)
      FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: this.controller,
            focusNode: focusNode,
          ),
          new FlatButton(
              onPressed: () => this.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
  }
}