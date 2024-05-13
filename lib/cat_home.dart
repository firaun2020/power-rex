import 'package:powerex/drawer.dart';
import 'package:powerex/story_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign GlobalKey to the Scaffold
      appBar: AppBar(
        title: Text('Category'),
        centerTitle: true,
        leading: BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer(); // Open the drawer
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      endDrawer: MyDrawer(),
      backgroundColor: Colors.pink.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const CircleAvatar(
              backgroundColor: Colors.black,
              minRadius: 40,
              child: Icon(
                Icons.fork_left,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        StoryPage(
                          story:
                              "She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!She was a hoe!",
                          title: "Hehehehehe",
                        ),
                      );
                      // Handle card tap
                      print('Card $index tapped!');
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.red,
                            width: 100,
                            height: 50,
                            child: Placeholder(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Story ${index + 1}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
