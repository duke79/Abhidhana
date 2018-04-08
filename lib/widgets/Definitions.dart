import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/data/DatabaseServices.dart';
import 'package:myapp/data/Strings.dart';

class Definitions extends StatefulWidget {
  final String word;

  Definitions({
    this.word,
    Key key,
  }) :super(key: key);

  @override
  State<StatefulWidget> createState() => new DefinitionsState();
}

class DefinitionsState extends State<Definitions> {
  List<String> _definitions = new List();

  @override
  void initState() {
    _loadDefinitions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _definitions.length < 1 ? new CircularProgressIndicator()
        : new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _definitions.map((String definition) {
        return new Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: new Text(
            definition,
            textScaleFactor: 2.0,
          ),
        );
      }).toList(),
    );
  }

  /*Methods*/
  Future _loadDefinitions() async {
    _definitions.clear();
    DatabaseServices.definitions(widget.word).forEach((String definition) {
      setState(() {
        _definitions.add(definition);
      });
    });
  }
}