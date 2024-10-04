import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkflow/state/note_state_notifier.dart';
import 'package:inkflow/views/mobile/components/note_list_mobile.dart';
import 'package:inkflow/views/shared/app_drawer.dart';

class MobileLayout extends ConsumerWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'InkFlow',
          style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLines: null,
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Title", border: OutlineInputBorder()),
              ),
              TextField(
                maxLines: null,
                controller: contentController,
                decoration: const InputDecoration(
                    hintText: "Content...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          final title = titleController.text;
          final content = contentController.text;
          ref.read(noteStateProvider.notifier).save(title, content);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteListMobile()));
          titleController.clear();
          contentController.clear();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
