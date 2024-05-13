import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Navigate to item 1 screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Navigate to item 2 screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Item 3'),
            onTap: () {
              // Navigate to item 3 screen
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
