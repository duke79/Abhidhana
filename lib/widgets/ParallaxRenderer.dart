import 'package:flutter/widgets.dart';

class ParallaxRenderer extends MultiChildRenderObjectWidget {
  @override
  RenderParallax createRenderObject(BuildContext context) {
    return new RenderParallax();
  }
  @override
  void updateRenderObject(BuildContext context, RenderParallax renderObject) {
    // TODO: implement updateRenderObject
    super.updateRenderObject(context, renderObject);
  }
}

class RenderParallax extends RenderBox{
}

