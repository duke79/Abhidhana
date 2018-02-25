import 'package:flutter/material.dart';

class SearchView extends StatelessWidget{

  final TextEditingController controller;

  SearchView(this.controller);

  @override
  Widget build(BuildContext context) {
    return new Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          new TextField(
            controller: this.controller,
          ),
          new FlatButton(
              onPressed: () => this.controller.clear(),
              child: new Icon(Icons.clear)),
        ]
    );
  }
}