import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testowanie/db/database.dart';
import 'package:testowanie/models/person.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({super.key});

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _birth = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();

  final db = DBHelper();
  bool _isSaving = false;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _birth.dispose();
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birth.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final person = Person(
        firstName: _first.text.trim(),
        lastName: _last.text.trim(),
        birthDate: _birth.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
      );

      final id = await db.insertPerson(person);
      
      if (id > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pomyślnie zapisano osobę'))
        );
        
        // Reset form
        _formKey.currentState!.reset();
        setState(() {
          _birth.clear();
        });
      } else {
        throw Exception('Nie udało się zapisać osoby');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Błąd podczas zapisywania: $e'),
          backgroundColor: Colors.red,
        )
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dodaj osobę")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _first,
                decoration: const InputDecoration(labelText: 'Imię'),
                validator: (v) =>
                    v == null || v.isEmpty ? "Podaj imię" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _last,
                decoration: const InputDecoration(labelText: 'Nazwisko'),
                validator: (v) =>
                    v == null || v.isEmpty ? "Podaj nazwisko" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birth,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Data urodzenia',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: pickDate,
                validator: (v) =>
                    v == null || v.isEmpty ? "Wybierz datę" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phone,
                decoration: const InputDecoration(labelText: 'Numer telefonu'),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? "Podaj numer telefonu" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    v == null || v.isEmpty ? "Podaj email" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(labelText: 'Adres'),
                validator: (v) =>
                    v == null || v.isEmpty ? "Podaj adres" : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSaving ? null : save,
                child: _isSaving 
                    ? const CircularProgressIndicator()
                    : const Text('Zapisz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}