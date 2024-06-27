import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];

  void _addNote(String note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(onAddNote: _addNote),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onAddNote;

  BuildAppBar({required this.onAddNote});

  @override
  Widget build(BuildContext context) {
    String newNote = '';

    return AppBar(
      centerTitle: true,
      title: const Text("Notlar Uygulaması"),
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Yeni Not Ekle'),
                content: TextField(
                  onChanged: (value) {
                    newNote = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Notunuzu girin',
                  ),
                  autofocus: true, // Klavye direkt olarak gösterilsin
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ekle'),
                    onPressed: () {
                      onAddNote(newNote);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
