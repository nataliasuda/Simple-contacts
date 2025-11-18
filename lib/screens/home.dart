import 'package:flutter/material.dart';
import 'package:testowanie/screens/delete_screen.dart';
import 'package:testowanie/screens/person_list.dart';
import 'add_person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final pages = [AddPersonScreen(), PersonListScreen(), DeleteScreen()];

  void _onNavTap(int idx) => setState(() => _currentIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Contacts'),
        leading: Navigator.canPop(context) ? BackButton() : null,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'Delete'),
        ],
      ),
      floatingActionButton: null,
    );
  }
}
