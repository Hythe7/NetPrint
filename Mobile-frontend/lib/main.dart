import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:printhub/firebase_options.dart';
import 'package:printhub/pages/newuploadscreen.dart';
import 'package:printhub/pages/signinscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Printhub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MergedTabScreen(),
    );
  }
}
