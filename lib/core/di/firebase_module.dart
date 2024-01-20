import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:pixel_place/main.dart';

@module
abstract class FirebaseModule {
  @singleton
  FirebaseAuth provideFirebaseAuth() => FirebaseAuth.instance;

 
  @preResolve
  @singleton
  Future<FirebaseDatabase> provideFirebaseProdDatabase() async {
    final app = await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: senderId,
          projectId: projectId) ,
    );

    return FirebaseDatabase.instanceFor(
      app: app,
      databaseURL: "https://pixel-60cc9-default-rtdb.europe-west1.firebasedatabase.app/"  // dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }
}
