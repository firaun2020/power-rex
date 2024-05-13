import 'package:powerex/constants.dart';
import 'package:powerex/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package for navigation

class LandingPage extends StatefulWidget {
  Future<List<Map<String, dynamic>>> topStories;
  LandingPage({super.key, required this.topStories});

  @override
  _LandingPageState createState() => _LandingPageState(topstories: topStories);
}

class _LandingPageState extends State<LandingPage> {
  bool showProgress = true;
  Future<List<Map<String, dynamic>>> topstories;
  _LandingPageState({required this.topstories});

  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() async {
    // Delay for 2 seconds
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        showProgress = false;
      });
    }

    // Navigate to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  width: 500,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/power-logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "TRUE STORIES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 40,
                  child: Text(
                    "Welcome to Power-Rex's Hidden Chapters",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
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
                      Get.off(HomeScreen(
                        snapshot: topstories,
                      ));
                    },
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Discover the Unspoken. Delve into the Depths of Taboo. Congratulations on your new purchase from Power-Rex and welcome to a secluded escape where the world’s most veiled stories come to light. You’ve unlocked access to an exclusive Power-Rex collection of real, raw, and riveting narratives shared anonymously.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                Visibility(
                  visible: showProgress,
                  child: const CircularProgressIndicator(
                    color: Colors.pink,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
