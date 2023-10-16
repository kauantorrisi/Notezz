import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:hive_crud/boxes.dart';
import 'package:hive_crud/note.dart';

class AllNotesPage extends StatefulWidget {
  const AllNotesPage({super.key, required this.boxNotes});

  final Box boxNotes;

  @override
  State<AllNotesPage> createState() => _AllNotesPageState();
}

class _AllNotesPageState extends State<AllNotesPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notezzz App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
          itemCount: boxNotes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (ctx, i) {
            Note note = boxNotes.getAt(i);
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),
                  child: Column(
                    children: [
                      Center(child: Text(note.title)),
                      const Divider(
                        color: Colors.black,
                      ),
                      Center(child: Text(note.description)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(
                            () => showModalBottomSheet(
                              context: context,
                              builder: (ctx) => Column(
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: note.title,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: descriptionController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: note.description,
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: InkWell(
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Editar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (titleController.text.isEmpty &&
                                              descriptionController
                                                  .text.isEmpty) {
                                            Navigator.pop(context);
                                            return;
                                          } else {
                                            boxNotes.putAt(
                                              i,
                                              Note(
                                                title: titleController.text,
                                                description:
                                                    descriptionController.text,
                                              ),
                                            );
                                          }
                                          titleController.text = '';
                                          descriptionController.text = '';
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            boxNotes.deleteAt(i);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => Column(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Titulo da nota',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descrição da nota',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Adicionar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      boxNotes.put(
                        'key_${titleController.text}',
                        Note(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                      );
                      titleController.text = '';
                      descriptionController.text = '';
                      Navigator.pop(context);
                    });
                  },
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
