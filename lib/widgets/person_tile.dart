import 'package:flutter/material.dart';
import '../models/person.dart';

class PersonTile extends StatelessWidget {
  final Person person;
  final VoidCallback? onTap;

  const PersonTile({super.key, required this.person, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${person.firstName} ${person.lastName}'),
      subtitle: Text('${person.phone} • ${person.email}'),
      trailing: Text(person.birthDate),
      onTap: onTap,
    );
  }
}
