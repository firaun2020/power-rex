import 'package:powerex/drawer.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  final String title;
  final String story;

  StoryPage({required this.title, required this.story});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        title: Text('Story'),
        centerTitle: true,
        leading: BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      endDrawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Placeholder(
                fallbackHeight: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(
                    story,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
