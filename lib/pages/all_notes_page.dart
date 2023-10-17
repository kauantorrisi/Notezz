import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:hive_crud/db/boxes.dart';
import 'package:hive_crud/models/note.dart';
import 'package:hive_crud/pages/note_page.dart';
import 'package:hive_crud/widgets/textformfield_widget.dart';

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
          'Notezz 🐝',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: GridView.builder(
          itemCount: boxNotes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (ctx, i) {
            Note note = boxNotes.getAt(i);

            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                GestureDetector(
                  child: Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, strokeAlign: 1),
                      color: Colors.yellow,
                    ),
                    child: Column(
                      children: [
                        Text(
                          note.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Divider(color: Colors.black),
                        Text(
                          note.description,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => NotePage(
                                noteTitle: note.title,
                                noteDescription: note.description,
                              ))),
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
                              backgroundColor: Colors.grey[850],
                              builder: (ctx) => Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text('Edite sua nota:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.yellowAccent[700],
                                          fontSize: 26,
                                        )),
                                  ),
                                  TextFormFieldWidget(
                                    controller: titleController,
                                    hintText: note.title,
                                  ),
                                  TextFormFieldWidget(
                                    controller: descriptionController,
                                    hintText: note.description,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: GestureDetector(
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
                                          if (titleController.text.isEmpty ||
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.black),
                      ),
                      const Spacer(),
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
          backgroundColor: Colors.grey[850],
          builder: (ctx) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Adicione sua nota:',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.yellowAccent[700],
                      fontSize: 26,
                    )),
              ),
              TextFormFieldWidget(
                controller: titleController,
                hintText: 'Título da nota',
              ),
              TextFormFieldWidget(
                controller: descriptionController,
                hintText: 'Descrição da nota',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
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
