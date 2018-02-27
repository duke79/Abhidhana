import 'package:flutter/material.dart';

/**
 * Created by Pulkit Singh on 2/27/2018.
 */

class Screen {
  static double height = 0.0;
  static double width = 0.0;
  static double GOLDEN_RATIO = 1.61803398875;

  static updateScreen(BuildContext context){
    MediaQueryData mq = MediaQuery.of(context);
    height = mq.size.height;
    width = mq.size.width;
  }
}