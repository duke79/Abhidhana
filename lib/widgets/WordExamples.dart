import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/data/Examples.dart';

class WordExamples extends StatefulWidget {
  final String word;

  WordExamples(this.word, {Key key}) :super(key: key);

  @override
  State<StatefulWidget> createState() => new WordExamplesState();
}

class WordExamplesState extends State<WordExamples>{
  List<String> _examples;
  var _controller = new PageController(); //no use as of now

  @override
  void initState() {
    Examples.getExamples(widget.word).then((examples) {
      setState(() => _examples = examples);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _examples == null ?
    new CircularProgressIndicator()
        : new PageView.builder(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemCount: _examples.length,
      itemBuilder: (context, index) {
        return new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new Text(_examples[index],textScaleFactor: 2.0,),
        );
      },
    );
  }
}