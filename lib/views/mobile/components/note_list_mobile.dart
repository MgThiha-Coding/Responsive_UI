import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inkflow/state/note_state_notifier.dart';
import 'package:inkflow/views/mobile/components/note_edit_mobile.dart';

class NoteListMobile extends ConsumerWidget {
  const NoteListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final data = notes[index];
            return ListTile(
              title: Text(
                  overflow: TextOverflow.ellipsis, maxLines: 1, data['title']),
              subtitle: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  data['content']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteEditMobile(
                                    title: data['title'],
                                    content: data['content'],
                                    index: index)));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        _deleteConfirmation(context, index, ref);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            );
          }),
    );
  }
}

void _deleteConfirmation(BuildContext context, int index, WidgetRef ref) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Are you sure to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref.read(noteStateProvider.notifier).delete(index);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'))
            ],
          ));
}
