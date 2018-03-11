import 'package:flutter/material.dart';
import 'package:myapp/model/MyLocale.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/widgets/BatteryLevel.dart';
import 'package:myapp/widgets/ChargingStatus.dart';
import 'package:myapp/widgets/MyDrawer.dart';
import 'package:myapp/model/Screen.dart';
import 'package:myapp/widgets/SearchBar.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateScreen(context);
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
          children: <Widget>[
            new InkWell(
              onTap: () => Navigator.of(context).pushNamed(Strings.route_search),
              child: new IgnorePointer (
                child: new Container(
                  margin: new EdgeInsets.only(
                    top: Screen.width / 20,
                    bottom: Screen.width / 20,
                  ),
                  width: (Screen.width * 0.6)/ Screen.GOLDEN_RATIO,
                  child: new Hero(
                    tag: Strings.widgetTag_prefix,
                    child: new SearchBar(
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
                  return new Text(MyLocale.of(context).value(Strings.localeKey_sheet));
                });
              }
              ,
              child: new Text(MyLocale.of(context).value(Strings.localeKey_showSheet)),
            ),
            new TabPageSelector(controller: _tabController)
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(Strings.tracesTag_quickTest + "aha! didChangeAppLifecycleState?");
  }
}
