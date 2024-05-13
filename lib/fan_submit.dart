import 'package:powerex/constants.dart';
import 'package:powerex/db/db.dart';
import 'package:powerex/home.dart';
import 'package:powerex/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FanSubmit extends StatelessWidget {
  TextEditingController _name = TextEditingController();
  TextEditingController _story = TextEditingController();
  DataBaseMatters dataBaseMatters = DataBaseMatters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Change the color here
          ),
          onPressed: () {
            Future<List<Map<String, dynamic>>> storiesData =
                dataBaseMatters.getTopStoriesData();

            // Navigate back to previous screen
            Get.offAll(HomeScreen(snapshot: storiesData));
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onLongPress: () {
            //Get.to(());
          },
          child: Container(
            height: 50,
            width: 150,
            child: Image.asset("lib/power-type.png"),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Name (Optional)',
                  hintText: 'Anonymous',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _story,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Your Story',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Validate story field
                  if (_story.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your story')),
                    );
                  } else {
                    // Submit story
                    await dataBaseMatters.submitStory(
                      _name.text.isNotEmpty ? _name.text : 'Anonymous',
                      _story.text,
                    );

                    // Show submission confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Story submitted!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Future<List<Map<String, dynamic>>> storiesData =
                        dataBaseMatters.getTopStoriesData();

                    // Navigate back to previous screen
                    Get.to(HomeScreen(snapshot: storiesData));
                  }
                },
                child: Text('Submit Story'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
