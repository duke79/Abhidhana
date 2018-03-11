import 'package:flutter/material.dart';
import 'package:myapp/data/Strings.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: new Text(Strings.str_accountName),
              accountEmail: new Text(Strings.str_accountEmail)),
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
                                  children: Strings.str_drawerItems.map((String id) {
                                    return new ListTile(
                                      leading: new CircleAvatar(
                                          child: new Text(id)),
                                      title: new Text(
                                          Strings.str_drawerItem + id),
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