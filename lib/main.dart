import 'package:flutter/material.dart';
import 'package:myapp/RouteHome.dart';
import 'package:myapp/RouteSearch.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:<String,WidgetBuilder>{
        "/":(_)=>new RouteHome(title: 'Flutter Demo Home Page'),
        "/search":(_)=>new RouteSearch(),
      }
    );
  }
}