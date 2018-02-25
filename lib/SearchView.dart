import 'package:flutter/material.dart';

class SearchViewParams{
  TextEditingController controller;
  bool focusOnStart;
  var onSubmittedCB;
  var onChangedCB;
  TextStyle style;
  InputDecoration decoration;

  SearchViewParams(this.controller, {
    this.focusOnStart = false,
    this.onSubmittedCB,
    this.onChangedCB,
    this.style,
    this.decoration,
  });
}

class SearchView extends StatefulWidget {
  SearchViewParams params;

  SearchView(this.params);

  @override
  SearchViewState createState() =>
      new SearchViewState(this.params);
}

class SearchViewState extends State<SearchView> {
  FocusNode focusNode = new FocusNode();
  SearchViewParams params;

  SearchViewState(this.params);

  @override
  void didUpdateWidget(SearchView oldWidget) {
    if (true == params.focusOnStart) {
      params.focusOnStart = false;
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: params.controller,
            focusNode: this.focusNode,
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
  }
}