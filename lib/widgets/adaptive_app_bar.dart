import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget, ObstructingPreferredSizeWidget{

  final Function startNewTransaction;
  final bool isIOS;

  AdaptiveAppBar({@required this.isIOS, @required this.startNewTransaction});

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
              onTap: () => startNewTransaction(context),
              child: Icon(CupertinoIcons.add)
          ),
        ],
      ),
    )
        : AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startNewTransaction(context),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(50,50);

  @override
  bool get fullObstruction => null;

}
