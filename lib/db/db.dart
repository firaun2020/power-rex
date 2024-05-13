import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMatters {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, List<String>>> getCategories() async {
    try {
      // Reference to the 'core_config' document in the 'main' collection
      DocumentReference documentRef =
          _firestore.collection('main').doc('core_config');

      // Fetch the document snapshot
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        // Extract the 'categories' array from the document data
        List<dynamic> categories = documentSnapshot.get('categories');

        // Convert the dynamic list to a list of strings
        List<String> categoryList =
            categories.map((category) => category.toString()).toList();

        print(categoryList);

        // Return a map with 'categories' as key and categoryList as value
        return {'categories': categoryList};
      } else {
        print('Document does not exist');
        return {'categories': []};
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return {'categories': []};
    }
  }
  // GET TOP & return title, id and url

  Future<List<Map<String, dynamic>>> getTopStoriesData() async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents where 'top' field is set to TRUE and limit to 15
      QuerySnapshot querySnapshot =
          await storiesRef.where('top', isEqualTo: true).limit(15).get();

      // Extract titles and ids from the documents
      List<Map<String, dynamic>> storiesData = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'] as String,
          'id': doc['id'],
          'url': doc['url'] as String,
        };
      }).toList();

      return storiesData;
    } catch (e) {
      print('Error fetching top stories: $e');
      return [];
    }
  }

// return a latest 5 stories

  Future<List<Map<String, dynamic>>> latest5Stories() async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents ordered by 'date_posted' field in descending order and limit to 5
      QuerySnapshot querySnapshot = await storiesRef
          .orderBy('date_posted', descending: true)
          .limit(5)
          .get();

      // Extract titles, ids, and urls from the documents
      List<Map<String, dynamic>> storiesData = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'] as String,
          'id': doc['id'],
          'url': doc['url'] as String,
        };
      }).toList();

      return storiesData;
    } catch (e) {
      print('Error fetching latest stories: $e');
      return [];
    }
  }

// return a specific story

  Future<Map<String, dynamic>> getOneStory(int storyId) async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents where 'id' field is equal to storyId
      QuerySnapshot querySnapshot =
          await storiesRef.where('id', isEqualTo: storyId).get();

      // Check if the querySnapshot has any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Extract details from the document
        Map<String, dynamic> theStory = {
          'title': querySnapshot.docs.first['title'] as String,
          'story_text': querySnapshot.docs.first['story_text'] as String,
          'reads': querySnapshot.docs.first['reads'],
          'likes': querySnapshot.docs.first['likes'],
          'url': querySnapshot.docs.first['url'] as String,
        };

        return theStory;
      } else {
        print('Document with id $storyId does not exist');
        return {};
      }
    } catch (e) {
      print('Error fetching the story: $e');
      return {};
    }
  }

  // All stories with Date Sort
  Future<List<Map<String, dynamic>>> allStoriesSortedByDate() async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents ordered by 'date_posted' field in descending order
      QuerySnapshot querySnapshot =
          await storiesRef.orderBy('date_posted', descending: true).get();

      // Extract titles, ids, and urls from the documents
      List<Map<String, dynamic>> storiesData = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'] as String,
          'id': doc['id'],
          'url': doc['url'] as String,
        };
      }).toList();

      return storiesData;
    } catch (e) {
      print('Error fetching stories: $e');
      return [];
    }
  }

// Submit fan story
  Future<void> submitStory(String name, String story) async {
    try {
      // Reference to the 'fan_submit' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('fan_submit');

      // Get the current timestamp
      DateTime timestamp = DateTime.now();

      // Convert timestamp to a string for use as document name
      String documentName = timestamp.toIso8601String();

      // Create a new document with the timestamp as the document name
      await storiesRef.doc(documentName).set({
        'name': name,
        'story': story,
        'timestamp': timestamp,
      });

      print('Story submitted successfully');
    } catch (e) {
      print('Error submitting story: $e');
    }
  }
}
