import 'package:powerex/db/db.dart';
import 'package:powerex/landing_page.dart';
import 'package:powerex/my_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final DataBaseMatters dbMatters = DataBaseMatters();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PowerRex',
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return const Center(child: Text('Error initializing Firebase'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              print("Connection Success");
              Future<List<Map<String, dynamic>>> storiesData =
                  dbMatters.getTopStoriesData();

              return FutureBuilder<List<Map<String, dynamic>>>(
                future: storiesData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.pink,
                      backgroundColor: Colors.white,
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Access the data from the snapshot

                  return LandingPage(
                    topStories: storiesData,
                  );
                },
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
