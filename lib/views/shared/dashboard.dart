import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkflow/state/note_state_notifier.dart';
import 'package:inkflow/views/desktop/components/note_edit_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteStateProvider);

    final titleController = TextEditingController();
    final contentController = TextEditingController();

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
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
                        maxLines: 30,
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
                      ref.read(noteStateProvider.notifier).save(title, content);
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: GridView.builder(
              itemCount: notes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 2,
              ),
              itemBuilder: (context, index) {
                final data = notes[index];
                return Card(
                  elevation: 10,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data['content'],
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialButton(
                              child: const Text('See Details'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NoteEditScreen(
                                      index,
                                      data['title'],
                                      data['content'],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            MaterialButton(
                              child: const Text('Delete Note'),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Are you sure to delete?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                ref
                                                    .read(noteStateProvider
                                                        .notifier)
                                                    .delete(index);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Delete')),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
