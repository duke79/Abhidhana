import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/data/Examples.dart';

class WordExamples extends StatelessWidget {
  final String word;
  List<String> _examples;

  WordExamples(this.word, {Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
//    _tabController = new TabController(vsync: this, length: 5);
    return new StatefulBuilder(builder: wordExamplesBuilder);
  }

  Widget wordExamplesBuilder(BuildContext context, StateSetter setState) {
    Examples.getExamples(word).then((examples) {
      setState(() => _examples = examples);
    });

    var _controller = new PageController(); //no use as of now
    return _examples == null ?
    new CircularProgressIndicator()
        : new PageView.builder(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemCount: _examples.length,
      itemBuilder: (context, index) {
        return new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new Text(_examples[index]),
        );
      },
    );
  }

}