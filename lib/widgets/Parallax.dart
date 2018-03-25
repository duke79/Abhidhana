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
        new Tween<double>(begin: 100.0, end: 30.0).animate(
            _animationController);

    _positionNotifier = new ValueNotifier<double>(0.0);
    _flowDelegate = new ParallaxFlowDelegate(position: _positionNotifier);
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

  ValueNotifier<double> position;

  ///  Listens to the notifications from `position`.
  ParallaxFlowDelegate({this.position}) : super(repaint: position);

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
    if(position.value > context.size.height)
      position.value = context.size.height;
    if(position.value < 0.0)
      position.value = 0.0;

    double positionRatio = position.value / context.size.height;
    _paintParallax(context,positionRatio);
    _paintBody(context,positionRatio);
  }

  void _paintParallax(FlowPaintingContext context, double positionRatio) {
    double childHeight = context
        .getChildSize(0)
        .height;
    double space = position.value;

    var _transform1 = new Matrix4.identity()
      ..scale(space / (childHeight),
          space / (childHeight), 1.0);

    context.paintChild(0, transform: _transform1);
  }

  void _paintBody(FlowPaintingContext context, double positionRatio) {
    var _transform2 = new Matrix4.identity()
      ..translate(0.0, position.value,
          0.0); //TODO(Explore):Does z value has any impact?
    context.paintChild(1, transform: _transform2);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return false;
  }
}