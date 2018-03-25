import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

//TODO(Enahncement): Hide parrallax with body (opacity).
class Parallax extends StatefulWidget {
  final Widget childParallax;
  final Widget childBody;
  final double parallaxRatio;
  final GlobalKey bottomWidget;

  /// A back ground color must be set for the [childBody], if [childParallax] is visible while overlapped by [childBody]. Example -
  ///
  /// /// ## Sample code
  ///
  /// ```childBody: new Container(
  ///        color: Colors.white,
  /// ```
  Parallax({@required this.childParallax, @required this.childBody,
    Key key, this.parallaxRatio = 0.3, this.bottomWidget}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ParallaxState();
}

class ParallaxState extends State<Parallax>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<num> _animation;
  FlowDelegate _flowDelegate;
  ValueNotifier<double> _positionNotifier;
  double _animationEnd;

  double get _bottomWidgetHeight =>
      widget.bottomWidget.currentContext.size.height;

  double get _parallaxPosition => widget.parallaxRatio * _contextHeight;

  double get _contextHeight => context.size.height;

  double get _bottomWidgetPosition => _contextHeight - _bottomWidgetHeight;

  double get _currentPosition => _positionNotifier.value;

  double get _currentAnimationPoint => 100 * _currentPosition / _contextHeight;

  double get _parallaxAnimationPoint =>
      100 * _parallaxPosition / _contextHeight;

  double get _topAnimationPoint => 0.0;

  double get _bottomAnimationPoint =>
      100.0; //100 * _bottomWidgetPosition / _contextHeight;

  bool get _bAtTop => _currentPosition == 0.0;

  bool get _bAboveMidParallax {
    return _currentPosition > 0.0
        && _currentPosition < ((_parallaxPosition) / 2);
  }

  bool get _bBelowMidParraxAboveParallax {
    return _currentPosition > ((_parallaxPosition) / 2)
        && _currentPosition < _parallaxPosition;
  }

  bool get _bAtParallax => _currentPosition == _parallaxPosition;

  bool get _bBelowParallaxAboveTheHalfwayBetweenParallaAndBottom {
    return _currentPosition > _parallaxPosition
        && _currentPosition <
            _parallaxPosition + (_bottomWidgetPosition - _parallaxPosition) / 2;
  }

  bool get _bBelowParallaxBelowTheHalfwayBetweenParallaAndBottom {
    return _currentPosition >
        _parallaxPosition + (_bottomWidgetPosition - _parallaxPosition) / 2
        && _currentPosition < _bottomWidgetPosition;
  }

  bool get _bAtBottom => _currentPosition == _bottomWidgetPosition;

  set _currentPosition(double value) => _positionNotifier.value = value;

  @override
  void initState() {
    _positionNotifier = new ValueNotifier<double>(0.0);
    _flowDelegate = new ParallaxFlowDelegate(
      positionNotifier: _positionNotifier,
      parallaxRatio: widget.parallaxRatio,
      bottomWidget: widget.bottomWidget,
    );

    _animationController = new AnimationController(
      vsync: this,
    );
    _initAnimation(begin: 0.0, end: 100.0 * widget.parallaxRatio);
    super.initState();
  }

  /// Builds the simple skeleton of the flow widget with two children - parallax & body
  /// Passes the [_flowDelegate] as the Flow delegate.
  /// Positioning of these children is to be handled by [_flowDelegate].
  @override
  Widget build(BuildContext context) {
    return new Flow(
      delegate: _flowDelegate,
      children: <Widget>[
        //TODO(Enhancement): Handle flings.
        //Fling candidates knows at the moment -
        // 1. If bottom position and _bottomWidget is tapped.
        // 2. If user drags and leaves at some random position (apart form top, bottom and parallaxRatio position).
        // 3. If the top position and _bottomWidget is tapped.
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onDragEnd,
          child: widget.childParallax,
        ),
        new GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onDragEnd,
          onTap: _onTap,
          child: widget.childBody,
        ),
      ],
    );
  }

  /// Handles the Animation callbacks.
  /// Updates the value of _positionNotifier, which in turn notifies the [_flowDelegate].
  ///  [_flowDelegate] takes care of repositioning the children.
  void _onAnimationValueChanged() {
    if (_animationEnd == _animation.value.toDouble())
      _animation.removeListener(_onAnimationValueChanged);
    _currentPosition =
        _animation.value.toDouble() * _contextHeight / 100;
  }

  void _initAnimation(
      {double begin = 0.0, double end = 100.0, double velocity = 5.0}) {
    _animationEnd = end;
    _animation =
        new Tween<double>(begin: begin, end: end)
            .animate(
            _animationController);
    _animation.addListener(_onAnimationValueChanged);
    _animationController.animateWith(
        new SpringSimulation(new SpringDescription.withDampingRatio(
            mass: 20.0,
            stiffness: 2.0,
            ratio: 1.0
        ), 0.0, 1.0, velocity));
  }

  ///  Handles dragging.
  ///  Updates the value of _positionNotifier, which in turn notifies the [_flowDelegate].
  ///  [_flowDelegate] takes care of repositioning the children.
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _currentPosition += details.delta.dy;
  }

  void _onDragEnd(DragEndDetails details) {
    if (_bAtTop || _bAtParallax || _bAtBottom)
      return;

    if (_bAboveMidParallax)
      _initAnimation(begin: _currentAnimationPoint,
          end: _topAnimationPoint);

    if (_bBelowMidParraxAboveParallax)
      _initAnimation(begin: _currentAnimationPoint,
          end: _parallaxAnimationPoint);

    if (_bBelowParallaxAboveTheHalfwayBetweenParallaAndBottom)
      _initAnimation(begin: _currentAnimationPoint,
          end: _parallaxAnimationPoint);

    if (_bBelowParallaxBelowTheHalfwayBetweenParallaAndBottom)
      _initAnimation(begin: _currentAnimationPoint,
          end: _bottomAnimationPoint);
  }

  void _onTap() {
    if (_bAtTop) {
      _initAnimation(
          begin: _topAnimationPoint, end: _parallaxAnimationPoint);
    }
    if (_bAtParallax) {
      _initAnimation(begin: _currentAnimationPoint,
          end: _bottomAnimationPoint);
    }
    if (_bAtBottom) {
      _initAnimation(
          begin: _bottomAnimationPoint, end: _parallaxAnimationPoint);
    }
  }
}

/// Positions the children of [Parallax] widget, i.e. Parallax & Body.
/// [ParallaxFlowDelegate.paintChildren] is called every time [positionNotifier] notifies of its updated value (thanks to [FlowDelegate._repaint]).
class ParallaxFlowDelegate extends FlowDelegate {

  ValueNotifier<double> positionNotifier;
  double parallaxRatio;

  /// Key to the bottom widget (part of the Body), which should never go out of view while dragging down.
  GlobalKey bottomWidget;

  ///  Listens to the notifications from [positionNotifier].
  ///  Initial position is set according to the [parallaxRatio].
  ParallaxFlowDelegate(
      {this.positionNotifier, this.parallaxRatio, this.bottomWidget})
      : super(repaint: positionNotifier);

  /// Asks for the child size constraints, called once in the beginning.
  /// Doesn't have an impact right now, won't matter if it's not overridden altogether.
  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return constraints.loosen();
  }

  /// Asks for the size constraints of the [Parallax] widget, called once in the beginning.
  /// There were some issues related to inifinite height etc. but got fixed whe a [SizedBox] was introduced as an ancestor for [Parallax].
  //TODO(Issue): There's still some white space left at the bottom of the screen, which means [Parallax] doesn't expand over the full height of the screen. This issue might need fixing.
  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }

  /// Paints the children according the matrices provided.
  /// All we need to from here is provide a [Matrix4] to the [context], to position/scale each child.
  @override
  void paintChildren(FlowPaintingContext context) {
    if (positionNotifier.value > context.size.height)
      positionNotifier.value = context.size.height;
    if (bottomWidget != null) {
      if (positionNotifier.value >
          context.size.height - bottomWidget.currentContext.size.height) {
        positionNotifier.value =
            context.size.height - bottomWidget.currentContext.size.height;
      }
    }
    if (positionNotifier.value < 0.0)
      positionNotifier.value = 0.0;

    double positionRatio = positionNotifier.value / context.size.height;
    _paintParallax(context, positionRatio);
    _paintBody(context, positionRatio);
  }

  /// Handles the painting for Parallax. [ParallaxFlowDelegate._paintBody] takes care of the Body.
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

  /// Handles the painting for Body. [ParallaxFlowDelegate._paintParallax] takes care of the Parallax.
  void _paintBody(FlowPaintingContext context, double positionRatio) {
    var transform = new Matrix4.identity()
      ..translate(0.0, positionNotifier.value,
          0.0); //TODO(Explore):Does z value has any impact?
    context.paintChild(1, transform: transform);
  }

  /// Name suggests that it might be used to ask for an opinion about repaint.
  /// But it's never called, kept only because it's mandatory to override.
  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return false;
  }
}