import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:testowanie/l10n/app_localizations.dart';
import 'package:testowanie/l10n/language_provider.dart';
import 'package:testowanie/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Contacts App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            useMaterial3: true,
          ),
          home: const MainMenuScreen(),
          locale: languageProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}