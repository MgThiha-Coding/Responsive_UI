import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkflow/state/note_state_notifier.dart';

class NoteEditMobile extends ConsumerWidget {
  final String title;
  final String content;
  final int index;
  const NoteEditMobile(
      {super.key,
      required this.title,
      required this.content,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: title);
    final contentController = TextEditingController(text: content);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
          actions: [
            IconButton(
                onPressed: () {
                  final title = titleController.text;
                  final content = contentController.text;
                  ref
                      .read(noteStateProvider.notifier)
                      .update(index, title, content);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: const Text(
                      'Saved',
                    ),
                    duration: Duration(seconds: 2),
                  ));
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  maxLines: null,
                  controller: titleController,
                  decoration: const InputDecoration(
                      hintText: "Title", border: UnderlineInputBorder()),
                ),
                TextField(
                  maxLines: null,
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: "Content",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
