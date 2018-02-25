import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  TextEditingController controller;
  bool focusOnStart;
  var onSubmittedCB;
  var onChangedCB;

  SearchView(this.controller, {
    this.focusOnStart = false,
    this.onSubmittedCB,
    this.onChangedCB,
  });

  @override
  SearchViewState createState() =>
      new SearchViewState(
        this.controller,
        focusOnStart: this.focusOnStart,
        onSubmittedCB: this.onSubmittedCB,
        onChangedCB: this.onChangedCB,
      );
}

class SearchViewState extends State<SearchView> {
  TextEditingController controller;
  bool focusOnStart = false;
  FocusNode focusNode = new FocusNode();
  var onSubmittedCB;
  var onChangedCB;


  SearchViewState(this.controller,
      {this.focusOnStart, this.onSubmittedCB, this.onChangedCB});

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
            focusNode: focusNode,
            onSubmitted: onSubmittedCB,
            onChanged: onChangedCB,
          ),
          new FlatButton(
              onPressed: () => this.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
  }
}