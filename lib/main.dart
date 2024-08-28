
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxelayers/Login%20and%20Signup%20Page/getstarted.dart';
import 'package:luxelayers/firebase_options.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    return  const MaterialApp(
      title: "LuxeLayers",
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),

    );
  }
}

