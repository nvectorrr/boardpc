import 'package:boardpc/views/problems_admin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'views/home.dart';
import 'views/problems.dart';
import 'views/journal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BoardPC',
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 42, 42, 42),
        unselectedWidgetColor: Colors.green,
        primarySwatch: Colors.green,
        highlightColor: Color(0xffFFE59D),
        scaffoldBackgroundColor: Color.fromARGB(255, 42, 42, 42),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/problems': (context) => ProblemsView(),
        '/journal': (context) => JournalView(),
        '/problems-admin': (context) => ProblemsAdminView(),
      },
    );
  }
}
