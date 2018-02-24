import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevel extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new BatteryLevelState();
  }
}

class BatteryLevelState extends State<BatteryLevel>{
  String _batteryLevel = 'Battery level: unknown.';

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text(
            _batteryLevel, key
            : const Key('Battery level label')
        ),
        new RaisedButton(
          child: const Text('Refresh'),
          onPressed: _getBatteryLevel,
        )
      ],
    );
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    const MethodChannel methodChannel =
    const MethodChannel('samples.flutter.io/battery');
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}

