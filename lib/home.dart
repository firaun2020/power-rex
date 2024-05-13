import 'package:powerex/add_story.dart';
import 'package:powerex/constants.dart';
import 'package:powerex/db/db.dart';
import 'package:powerex/fan_submit.dart';
import 'package:powerex/story_page.dart';
import 'package:powerex/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> snapshot;

  HomeScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: GestureDetector(
            onLongPress: () {
              Get.to(StoryForm());
            },
            child: Container(
              height: 50,
              width: 150,
              child: Image.asset("lib/power-type.png"),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: headingText(Colors.white, klightBlue, "TOP SHARE"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: snapshot,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    int itemCount = snapshot.data!.length;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            DataBaseMatters dataBaseMatters = DataBaseMatters();

                            Map<String, dynamic> storyToShow =
                                await dataBaseMatters
                                    .getOneStory(snapshot.data![index]["id"]);

                            Get.to(StoryHomePage(
                              storyObject: storyToShow,
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    child: Image.network(
                                      snapshot.data![index]['url'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: 100,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index]['title'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: headingText(
                            Colors.white, klightBlue, "LATEST ENCOUNTERS"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 16, // Assuming you always want to display 5 items
                  itemBuilder: (context, index) {
                    // Call the latest5Stories function to get the data
                    // call all instead
                    Future<List<Map<String, dynamic>>> storiesFuture =
                        DataBaseMatters().allStoriesSortedByDate();

                    // Return a FutureBuilder to handle the asynchronous data retrieval
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: storiesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for data, return a placeholder or loading indicator
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If an error occurs while fetching data, display an error message
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // If data is successfully retrieved, display the ListView
                          List<Map<String, dynamic>> storiesData =
                              snapshot.data ?? [];
                          // Check if index is within bounds of storiesData list
                          if (index < storiesData.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: GestureDetector(
                                onTap: () async {
                                  DataBaseMatters dataBaseMatters =
                                      DataBaseMatters();

                                  Map<String, dynamic> storyToShow =
                                      await dataBaseMatters.getOneStory(
                                          snapshot.data![index]["id"]);

                                  Get.to(StoryHomePage(
                                    storyObject: storyToShow,
                                  ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                storiesData[index]['url']),
                                            fit: BoxFit.cover),
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        width: 250,
                                        height: 30,
                                        child: Text(
                                          storiesData[index]['title'] ?? '',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // If index exceeds the length of storiesData list, return an empty container
                            return Container();
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: headingText(Colors.white, klightBlue,
                              "SUBMIT YOUR EXPERIENCE"))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlue),
                  alignment: Alignment.center,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius to make edges less rounded
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity,
                        50), // Adjust the height to make it bigger
                  ),
                ),
                onPressed: () {
                  Get.off(FanSubmit());
                },
                child: const Text(
                  "Share yours",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
