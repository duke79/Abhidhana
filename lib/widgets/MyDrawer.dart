import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: new Text("Vilokan Labs"),
              accountEmail: new Text("VilokanLabs@gmail.com")),
          new MediaQuery.removePadding(
              context: context,
              child: new Expanded(
                  child: new ListView(
                      children: <Widget>[
                        new Stack(
                            children: <Widget>[
                              // The initial contents of the drawer.
                              new FadeTransition(
                                opacity: null,
                                child: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: ["a", "b"].map((String id) {
                                    return new ListTile(
                                      leading: new CircleAvatar(
                                          child: new Text(id)),
                                      title: new Text('Drawer item $id'),
                                      onTap: null,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ]
                        )
                      ]
                  )
              ))
        ]
    );
  }
}