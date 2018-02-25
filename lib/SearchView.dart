import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  TextEditingController controller;
  bool focusOnStart;
  var onSubmittedCB;
  var onChangedCB;
  TextStyle style;

  SearchView(this.controller, {
    this.focusOnStart = false,
    this.onSubmittedCB,
    this.onChangedCB,
    this.style,
  });

  @override
  SearchViewState createState() =>
      new SearchViewState(
        this.controller,
        focusOnStart: this.focusOnStart,
        onSubmittedCB: this.onSubmittedCB,
        onChangedCB: this.onChangedCB,
        style: this.style,
      );
}

class SearchViewState extends State<SearchView> {
  TextEditingController controller;
  bool focusOnStart = false;
  FocusNode focusNode = new FocusNode();
  var onSubmittedCB;
  var onChangedCB;
  TextStyle style;


  SearchViewState(this.controller, {
    this.focusOnStart,
    this.onSubmittedCB,
    this.onChangedCB,
    this.style,
  });

  @override
  void didUpdateWidget(SearchView oldWidget) {
    if (true == this.focusOnStart) {
      focusOnStart = false;
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: this.controller,
            focusNode: this.focusNode,
            onSubmitted: this.onSubmittedCB,
            onChanged: this.onChangedCB,
            style: this.style,
          ),
          new FlatButton(
              onPressed: () => this.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
  }
}