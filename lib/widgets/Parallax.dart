import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Parallax extends StatefulWidget {
  final Widget childParallax;
  final Widget childBody;
  final double heightParallaxAtStarting;

  Parallax({@required this.childParallax, @required this.childBody,
    Key key, this.heightParallaxAtStarting = 200.0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParallaxState();
}

class ParallaxState extends State<Parallax>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<num> _animation;
  Offset _dragDelta = new Offset(0.0, 0.0);
  FlowDelegate _flowDelegate;

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _animation =
        new Tween(begin: 600.0, end: 0.0).animate(_animationController);
//    _animation.addListener(() {
//      setState(() => null);
//    });
    _flowDelegate = new ParallaxFlowDelegate(repaint: _animation);
    _animationController.animateWith(
        new SpringSimulation(new SpringDescription.withDampingRatio(
            mass: 200.0,
            stiffness: 2.0,
            ratio: 1.0
        ), 0.0, 1.0, 1.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _parallaxTopMargin = _animation.value.toDouble() / 2 +
        _dragDelta.dy / 4;
    var _parallaxHeight = _animation.value.toDouble() / 2 +
        widget.heightParallaxAtStarting +
        _dragDelta.dy / 2;
    var _bodyTopMargin = (1.5 * _animation.value.toDouble()) +
        widget.heightParallaxAtStarting +
        _dragDelta.dy;

    _parallaxTopMargin = _parallaxTopMargin > 0.0 ? _parallaxTopMargin : 0.0;
    _parallaxHeight =
    _parallaxHeight > widget.heightParallaxAtStarting ? _parallaxHeight : widget
        .heightParallaxAtStarting;
    _bodyTopMargin = _bodyTopMargin > 0.0 ? _bodyTopMargin : 0.0;

    return new Flow(
      delegate: _flowDelegate,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(top: _parallaxTopMargin,),
          height: _parallaxHeight,
          child: new GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            child: widget.childParallax,
          ),
        ),
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          child: new Container(
            margin: new EdgeInsets.only(
              top: _bodyTopMargin,
            ),
            child: widget.childBody,
          ),
        ),
      ],
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragDelta += details.delta;
    });
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({Listenable repaint}) : super(repaint: repaint);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    int nbrChildren = context.childCount;
//    context.paintChild(
//        0, transform: new Matrix4.diagonal3Values(200.0, 200.0, 200.0));
    List<double> values = new List();
    values.add(1.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(1.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(1.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    values.add(0.0);
    var _transform = new Matrix4.fromList(values);
    context.paintChild(1, transform: new Matrix4.identity());
  }

  @override
  bool shouldRelayout(FlowDelegate oldDelegate) {
    return false;
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return false;
  }

}