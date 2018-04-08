import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChargingStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChargingStatusState();
}

class ChargingStatusState extends State<ChargingStatus>{

  String _chargingStatus = 'Battery status: unknown.';

  @override
  void initState() {
    const EventChannel eventChannel =
    const EventChannel('samples.flutter.io/charging');
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    return new Text(_chargingStatus);
  }

  void _onEvent(Object event) {
    setState(() {
      _chargingStatus =
      "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";
    });
  }

  void _onError(PlatformException error) {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }
}

