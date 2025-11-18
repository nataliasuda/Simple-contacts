import 'package:flutter/material.dart';
import 'package:testowanie/db/database.dart';
import 'package:testowanie/models/person.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final db = DBHelper();
  late Future<List<Person>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() => _future = db.getPersons();

  Future<void> _delete(int id) async {
    await db.deletePerson(id);
    _reload();
    setState(() {});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Usunięto')));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        final persons = snapshot.data ?? [];
        if (persons.isEmpty)
          return const Center(child: Text('Brak osób do usunięcia'));
        return ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, i) {
            final p = persons[i];
            return ListTile(
              title: Text('${p.firstName} ${p.lastName}'),
              subtitle: Text(p.email),
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Potwierdź'),
                    content: const Text('Czy na pewno usunąć tę osobę?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Anuluj'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _delete(p.id!);
                        },
                        child: const Text('Usuń'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
