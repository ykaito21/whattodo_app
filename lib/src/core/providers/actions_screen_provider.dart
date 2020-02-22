import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../services/database_service.dart';

class ActionsScreenProvider {
  AppDatabase _appDatabase;

  set currentDatabase(AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _actionsScreenTagSubject.close();
    _searchController.dispose();
    _searchSubject.close();
  }

  // For tag
  List<Tag> _selectedTags = [];
  List<Tag> get selectedTags => _selectedTags;

  void onPressedTag(Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _actionsScreenTagSubject.add(_selectedTags);
  }

  final BehaviorSubject<List<Tag>> _actionsScreenTagSubject =
      BehaviorSubject<List<Tag>>.seeded(<Tag>[]);
  Stream<List<Tag>> get streamActionsScreenSelectedTags =>
      _actionsScreenTagSubject.stream;

  // For keywords
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final BehaviorSubject<List<String>> _searchSubject =
      BehaviorSubject<List<String>>.seeded(<String>[]);
  // List<String> get searchedKeywords => _searchSubject.value;
  Stream<List<String>> get streamSearchKeywords => _searchSubject.stream;

  void searchInput(String input) {
    final List<String> keywords = input.split(' ');
    keywords.removeWhere((keyword) => keyword.isEmpty);
    _searchSubject.add(keywords);
  }

  void clearKeywords() {
    // to avoid exception
    Future.delayed(Duration(milliseconds: 50)).then(
      (_) {
        _searchController.clear();
        _searchSubject.add(<String>[]);
      },
    );
  }

  // can be stream
  bool toggleIcon() => _searchController.text == '';
}
