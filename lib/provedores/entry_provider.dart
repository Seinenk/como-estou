import 'package:flutter/material.dart';
import '../modelos/entry_model.dart';

class EntryProvider with ChangeNotifier {
  List<Entry> _entries = [];

  List<Entry> get entries => _entries;

  void addEntry(Entry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void updateEntry(Entry updatedEntry) {
    final index = _entries.indexWhere((entry) => entry.id == updatedEntry.id);
    if (index != -1) {
      _entries[index] = updatedEntry;
      notifyListeners();
    }
  }

  void deleteEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}