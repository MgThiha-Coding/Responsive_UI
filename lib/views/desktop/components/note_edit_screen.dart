import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkflow/state/note_state_notifier.dart';

class NoteEditScreen extends ConsumerWidget {
  final String title;
  final String content;
  final int index;
  const NoteEditScreen(this.index, this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: title);
    final contentController = TextEditingController(text: content);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    maxLines: 1,
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLines: 20,
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: "Content...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final content = contentController.text;
                  ref
                      .read(noteStateProvider.notifier)
                      .update(index, title, content);
                  Navigator.pop(context);
                  titleController.clear();
                  contentController.clear();
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
