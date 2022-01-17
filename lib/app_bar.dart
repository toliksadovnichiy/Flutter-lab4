import 'package:flutter/material.dart';
import "parse_json_widget.dart";

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final void Function() changeFloatingButton;
  AppBarWidget(this.changeFloatingButton);

  @override
  Widget build(BuildContext context) {
    return getAppBarWidget(context);
  }

  Widget getAppBarWidget(BuildContext context) {
    return AppBar(
        toolbarHeight: 50,
        leading: Container(
            child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParseWidget(1)),
            );
            print(res);
          },
        )),
        title: Text(
          'Twitter',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              changeFloatingButton();
            },
            child: Container(
              child: Icon(Icons.send),
              margin: EdgeInsets.only(right: 10),
            ),
          ),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
