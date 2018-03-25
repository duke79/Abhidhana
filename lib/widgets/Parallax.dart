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
    _screenSize = MediaQuery.of(context).size;
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

  void _onAnimationValueChanged(){
    if(null != _screenSize)
      _positionNotifier.value = _animation.value.toDouble()*_screenSize.height/100;
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
            mass: 2.0,
            stiffness: 2.0,
            ratio: 1.0
        ), 0.0, 1.0, 1.0));
  }
}

class ParallaxFlowDelegate extends FlowDelegate {

  ValueNotifier<double> position;
  double _lastPosition;

  double get _parallaxTopMargin {
    double parallaxTopMargin = (8 * position.value) / 4;
    parallaxTopMargin = parallaxTopMargin > 0.0 ? parallaxTopMargin : 0.0;
    return parallaxTopMargin;
  }

  double get _parallaxHeight {
    double parallaxHeight = (8 * position.value) / 2;
    return parallaxHeight;
  }

  double get _bodyTopMargin {
    double bodyTopMargin = (8 * position.value);
    return bodyTopMargin;
  }

  ///  Listens to the notifications from `position`.
  ParallaxFlowDelegate({this.position}) : super(repaint: position) {
    _lastPosition = 0.0;
  }

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
    context.paintChild(0, transform: new Matrix4.identity());
    var _transform = new Matrix4.identity()
    ..translate(0.0,position.value,20.0);
    context.paintChild(1, transform: _transform);
    _lastPosition = position.value;
  }

  @override
  bool shouldRelayout(ParallaxFlowDelegate oldDelegate) {
    return false;
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return oldDelegate.position.value != position.value;
  }

}