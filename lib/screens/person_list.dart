import 'package:flutter/material.dart';
import 'package:testowanie/db/database.dart';
import 'package:testowanie/models/person.dart';
import 'package:testowanie/widgets/person_tile.dart';

class PersonListScreen extends StatefulWidget {
  const PersonListScreen({super.key});

  @override
  State<PersonListScreen> createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  final db = DBHelper();
  late Future<List<Person>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() => _future = db.getPersons();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final persons = snapshot.data ?? [];
        if (persons.isEmpty)
          return const Center(child: Text('Brak zapisanych osób'));
        return RefreshIndicator(
          onRefresh: () async {
            _reload();
            setState(() {});
          },
          child: ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, i) => PersonTile(person: persons[i]),
          ),
        );
      },
    );
  }
}
