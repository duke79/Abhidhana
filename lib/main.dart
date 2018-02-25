import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/BatteryLevel.dart';
import 'package:myapp/ChargingStatus.dart';
import 'package:myapp/MyDrawer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      drawer: new Drawer(
          child: new MyDrawer()
      ),
      body: new Center(
        child: new Column
          (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <
              Widget>[
            new Text(
              'You have pushed the button',
            ),
            new Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
            new Text(
              'times',
            ),
            new BatteryLevel(),
            new ChargingStatus(),
            new RaisedButton(
                onPressed:
                    () {
                  _scaffoldKey.currentState.showBottomSheet<Null>((
                      BuildContext context) {
                    return new Text("fdsf");
                  });
                }
                ,
                child: const Text('showSheet')
            ),
            new Stack(
                alignment: const Alignment(
                    1.0, 1.0),
                children: <Widget>
                [
                  new TextField(controller: _controller,),
                  new FlatButton(
                      onPressed: () {
                        _controller.clear();
                      },
                      child: new Icon(Icons.clear)
                  )
                ]
            ),
            new TabPageSelector(controller: _tabController)
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.clear),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("aha! didChangeAppLifecycleState?");
  }
}
