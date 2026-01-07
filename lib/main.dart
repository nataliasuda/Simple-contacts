import 'package:flutter/material.dart';
import 'package:testowanie/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Contacts',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MainMenuScreen(),
    );
  }
}
