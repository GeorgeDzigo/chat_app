import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import './screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterChat',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnap) {
          if (userSnap.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnap.hasData) {
            return ChatScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
