import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pixel_place/injector.dart';
import 'package:pixel_place/presentation/pages/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await configureDependencies(Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: senderId,
          projectId: projectId) /* DefaultFirebaseOptions.currentPlatform, */
      );
}

const String apiKey =
    "AIzaSyDtKdZz991e2jZ8qhDokGNG3ud2wTppKSM";
const String appId = "594537212620";
const String projectId = "pixel-60cc9";
const String senderId = "594537212620";
