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

  final pages = [
    const AddPersonScreen(),
    const PersonListScreen(),
    const DeleteScreen(),
  ];

  void _onNavTap(int idx) => setState(() => _currentIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kontakty',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Color(0xFF111827),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
                color: const Color(0xFF374151),
              )
            : null,
        actions: [
          if (_currentIndex == 1 || _currentIndex == 2)
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: () => setState(() {}),
              color: const Color(0xFF374151),
            ),
        ],
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF6366F1),
            unselectedItemColor: const Color(0xFF9CA3AF),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add_alt_1_rounded),
                activeIcon: Icon(Icons.person_add_alt_1_rounded),
                label: 'Dodaj',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                activeIcon: Icon(Icons.list_alt_rounded),
                label: 'Lista',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delete_outline_rounded),
                activeIcon: Icon(Icons.delete_rounded),
                label: 'Usuń',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
