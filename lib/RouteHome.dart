import 'package:flutter/material.dart';
import 'package:myapp/BatteryLevel.dart';
import 'package:myapp/ChargingStatus.dart';
import 'package:myapp/MyDrawer.dart';
import 'package:myapp/SearchView.dart';

class RouteHome extends StatefulWidget {
  RouteHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<RouteHome>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    final TextEditingController _controller = new TextEditingController();

    return new Scaffold(
      key: _scaffoldKey,
      /*appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        *//*title: new Text(widget.title),*//*
      ),*/
      drawer: new Drawer(
          child: new MyDrawer()
      ),
      body: new Center(
        child: new Column
          (
          children: <Widget>[
            new InkWell(
              onTap: () => Navigator.of(context).pushNamed("/search"),
              child: new IgnorePointer (
                child: new Container(
                  margin: new EdgeInsets.only(
                    top: mq.size.width / 20,
                    bottom: mq.size.width / 20,
                  ),
                  width: mq.size.width / 2.6,
                  child: new Hero(
                    tag: "SearchViewTag",
                    child: new SearchView(
                      new SearchViewParams(
                        _controller,
                        decoration: new InputDecoration(
                          labelStyle: Theme
                              .of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Theme
                              .of(context)
                              .primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
              child: const Text('showSheet'),
            ),
            new TabPageSelector(controller: _tabController)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("aha! didChangeAppLifecycleState?");
  }
}
