import 'package:flutter/material.dart';
import 'package:testowanie/screens/add_person.dart';
import 'package:testowanie/screens/delete_screen.dart';
import 'package:testowanie/screens/person_list.dart';
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontakty')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _menuButton(
              context,
              Icons.person_add,
              'Dodaj kontakt',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPersonScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              Icons.list,
              'Lista kontaktów',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PersonListScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              Icons.delete,
              'Usuń kontakt',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeleteScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        onPressed: onTap,
      ),
    );
  }
}
