import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Parallax extends StatefulWidget {
  final Widget childParallax;
  final Widget childBody;

  Parallax(this.childParallax, this.childBody, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParallaxState();
}

class ParallaxState extends State<Parallax>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<num> _animation;
  Offset _dragDelta = new Offset(0.0, 0.0);

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _animation =
        new Tween(begin: 600.0, end: 0.0).animate(_animationController);
    _animation.addListener(() {
      setState(() => null);
    });
    _animationController.animateWith(
        new SpringSimulation(new SpringDescription.withDampingRatio(
            mass: 2.0,
            stiffness: 2.0,
            ratio: 1.0
        ), 0.0, 1.0, 1.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _parallaxTopMargin = _animation.value.toDouble() / 2 +
        _dragDelta.dy / 4;
    var _parallaxHeight = _animation.value.toDouble() / 2 + 200 +
        _dragDelta.dy / 2;
    var _bodyTopMargin = (1.5 * _animation.value.toDouble()) + 200.0 +
        _dragDelta.dy;


    return new Stack(
      children: <Widget>[
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          child: new Container(
            margin: new EdgeInsets.only(
              top: _parallaxTopMargin > 0.0 ? _parallaxTopMargin : 0.0,
            ),
            height: _parallaxHeight > 0.0 ? _parallaxHeight : 0.0,
            child: widget.childParallax,
          ),
        ),
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          child: new Container(
            margin: new EdgeInsets.only(
              top: _bodyTopMargin > 0.0 ? _bodyTopMargin : 0.0,
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