import 'package:powerex/constants.dart';
import 'package:flutter/material.dart';

class StoryHomePage extends StatelessWidget {
  final Map<String, dynamic> storyObject;

  StoryHomePage({Key? key, required this.storyObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: klightBlue, // Change the color here
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(storyObject['url']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      storyObject['title'],
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Likes: ${storyObject['likes'] ?? ''}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Total Reads: ${storyObject['reads'] ?? ''}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Text(
                  storyObject['story_text'] ?? 'Error Loading',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
