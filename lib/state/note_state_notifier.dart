import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final noteStateProvider =
    StateNotifierProvider<NoteStateNotifier, List<Map<dynamic, dynamic>>>(
        (ref) {
  return NoteStateNotifier();
});

class NoteStateNotifier extends StateNotifier<List<Map<dynamic, dynamic>>> {
  NoteStateNotifier() : super([]) {
    load();
  }
  late Box box;
  Future<void> load() async {
    await Hive.initFlutter();
    await Hive.openBox('database');
    box = Hive.box('database');
    final loaded = box.get('notes', defaultValue: []);
    state = List<Map<dynamic, dynamic>>.from(loaded);
  }

  void save(String title, String content) {
    if (title.isNotEmpty && content.isNotEmpty) {
      state = [
        ...state,
        ({'title': title, 'content': content})
      ];
      box.put('notes', state);
    }
  }

  void delete(index) {
    state.removeAt(index);
    box.put('notes', state);
    state = [...state];
  }

  void update(int index, String title, String content) {
    if (title.isNotEmpty || content.isNotEmpty) {
      // Create a new note map
      final newNote = {'title': title, 'content': content};

      // Update the note at the given index
      state = [
        for (int i = 0; i < state.length; i++) i == index ? newNote : state[i],
      ];

      // Update the box with the new state
      box.put('notes', state);
    }
  }
}
