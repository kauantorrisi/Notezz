import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_crud/boxes.dart';
import 'package:hive_crud/note.dart';

import 'pages/all_notes_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  boxNotes = await Hive.openBox<Note>('boxNotes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notezzz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AllNotesPage(boxNotes: boxNotes),
    );
  }
}
