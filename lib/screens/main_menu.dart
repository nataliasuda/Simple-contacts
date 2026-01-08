import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testowanie/l10n/app_localizations.dart';
import 'package:testowanie/l10n/language_provider.dart';
import 'package:testowanie/screens/add_person.dart';
import 'package:testowanie/screens/delete_screen.dart';
import 'package:testowanie/screens/person_list.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              languageProvider.toggleLanguage();
            },
            tooltip: languageProvider.locale.languageCode == 'pl' 
                ? 'Switch to English' 
                : 'Przełącz na Polski',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _menuButton(
              context,
              Icons.person_add,
              l10n.addContact,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPersonScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              Icons.list,
              l10n.contactList,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PersonListScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _menuButton(
              context,
              Icons.delete,
              l10n.deleteContact,
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