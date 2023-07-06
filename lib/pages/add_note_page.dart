import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unleash Your Creativity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _noteController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Hier können Sie den Code zum Speichern der Notiz implementieren
                String title = _titleController.text;
                String note = _noteController.text;
                // Fügen Sie den Code zum Speichern der Notiz hinzu, z. B. eine Funktion, die Sie bereits haben
                saveNote(title, note);
                // Zurück zur vorherigen Seite navigieren
                Navigator.pop(context);
              },
              child: Text('Back to reality'),
            ),
          ],
        ),
      ),
    );
  }

  void saveNote(String title, String note) {

    print('Title: $title');
    print('Note: $note');
  }
}
