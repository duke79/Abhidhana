import 'package:flutter/widgets.dart';
import 'package:myapp/data/Examples.dart';

class WordExamples extends StatelessWidget {
  final String word;

  WordExamples(this.word, {Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
//    _tabController = new TabController(vsync: this, length: 5);
    String examples = Examples.getExamples(word);
    var _controller = new PageController(); //no use as of now
    return new PageView.builder(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemBuilder: (context, index) {
        return new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new Text("Example"),
        );
      },
    );
  }
}