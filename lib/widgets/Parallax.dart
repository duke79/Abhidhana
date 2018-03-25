import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Parallax extends StatefulWidget {
  final Widget childParallax;
  final Widget childBody;
  final double parallaxRatio;

  Parallax({@required this.childParallax, @required this.childBody,
    Key key, this.parallaxRatio = 0.3}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParallaxState();
}

class ParallaxState extends State<Parallax>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<num> _animation;
  FlowDelegate _flowDelegate;
  ValueNotifier<double> _positionNotifier;
  Size _screenSize;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery
        .of(context)
        .size;
    return new Flow(
      delegate: _flowDelegate,
      children: <Widget>[
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          child: widget.childParallax,
        ),
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          child: widget.childBody,
        ),
      ],
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _positionNotifier.value += details.delta.dy;
  }

  void _onAnimationValueChanged() {
    if (null != _screenSize)
      _positionNotifier.value =
          _animation.value.toDouble() * _screenSize.height / 100;
  }

  void _initAnimation() {
    _animationController = new AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _animation =
        new Tween<double>(begin: 0.0, end: 100 * widget.parallaxRatio)
            .animate(
            _animationController);

    _positionNotifier = new ValueNotifier<double>(0.0);
    _flowDelegate = new ParallaxFlowDelegate(
        positionNotifier: _positionNotifier,
        parallaxRatio: widget.parallaxRatio);
    _animation.addListener(_onAnimationValueChanged);
    _animationController.animateWith(
        new SpringSimulation(new SpringDescription.withDampingRatio(
            mass: 20.0,
            stiffness: 2.0,
            ratio: 1.0
        ), 0.0, 1.0, 1.0));
  }
}

class ParallaxFlowDelegate extends FlowDelegate {

  ValueNotifier<double> positionNotifier;
  double parallaxRatio;

  ///  Listens to the notifications from `position`.
  ParallaxFlowDelegate({this.positionNotifier, this.parallaxRatio})
      : super(repaint: positionNotifier);

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
    if (positionNotifier.value > context.size.height)
      positionNotifier.value = context.size.height;
    if (positionNotifier.value < 0.0)
      positionNotifier.value = 0.0;

    double positionRatio = positionNotifier.value / context.size.height;
    _paintParallax(context, positionRatio);
    _paintBody(context, positionRatio);
  }

  void _paintParallax(FlowPaintingContext context, double positionRatio) {
    var transform = new Matrix4.identity();

    if (positionRatio > parallaxRatio) {
      transform.scale(positionNotifier.value / context.size.height,
          positionNotifier.value / context.size.height, 1.0);
    }
    else {
      transform.scale(parallaxRatio, parallaxRatio, 1.0);
    }

    context.paintChild(0, transform: transform);
  }

  void _paintBody(FlowPaintingContext context, double positionRatio) {
    var transform = new Matrix4.identity()
      ..translate(0.0, positionNotifier.value,
          0.0); //TODO(Explore):Does z value has any impact?
    context.paintChild(1, transform: transform);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return false;
  }
}