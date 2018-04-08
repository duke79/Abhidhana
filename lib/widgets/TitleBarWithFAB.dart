import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/widgets/TitleBar.dart';

class TitleBarWithFAB extends StatelessWidget {
  final String title;
  VoidCallback onFABPressed;

  TitleBarWithFAB({Key key, this.title, this.onFABPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fab = new FloatingActionButton(
      child: new Icon(Icons.volume_up),
      onPressed: onFABPressed,
      elevation: 1.0,
      backgroundColor: Colors.green,
    );
    Widget bar = new TitleBar(
      title: title,
    );

    final List<Widget> children = <Widget>[];
    children.add(new LayoutId(id: _TitleBarSlot.bar, child: bar));
    children.add(new LayoutId(id: _TitleBarSlot.fab, child: fab));

    return new CustomMultiChildLayout(
      children: children,
      delegate: new TitleBarWithFABDelegate(),
    );
  }
}

enum _TitleBarSlot {
  fab,
  bar,
}

class TitleBarWithFABDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrain(new Size.fromHeight(76.0));
  }

  @override
  void performLayout(Size size) {
    layoutChild(_TitleBarSlot.bar, new BoxConstraints.tight(size));
    //positionChild(_TitleBarSlot.bar, new Offset(200.0, -50.0));
    layoutChild(_TitleBarSlot.fab, new BoxConstraints.loose(size));
    positionChild(_TitleBarSlot.fab, new Offset(580.0, -25.0));
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}