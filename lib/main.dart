import 'package:events/screens/event_screen.dart';
import 'package:events/screens/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future testData() async {
    CollectionReference eventCollection = db.collection('event_details');
    QuerySnapshot querySnapshot = await eventCollection.get();
    List<QueryDocumentSnapshot> allDocSnapshot = querySnapshot.docs;
    allDocSnapshot.forEach((element) {
      print(element.get('date'));
    });
    var data = (await db.collection('event_details').get()).docs;
    data.forEach((element) => print(element.id));
  }

  @override
  Widget build(BuildContext context) {
    //testData();
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LaunchScreen(),
    );
  }
}
