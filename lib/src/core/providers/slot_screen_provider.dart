import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../services/database_service.dart';

class SlotScreenProvider {
  AppDatabase _appDatabase;

  set currentDatabase(AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _slotScrollController.dispose();
    _slotScreenTagSubject.close();
  }

// FOR SLOT
  final FixedExtentScrollController _slotScrollController =
      FixedExtentScrollController();
  final Random random = Random();
  FixedExtentScrollController get slotScrollController => _slotScrollController;

  void slotStart() {
    _slotScrollController.animateToItem(
      _slotScrollController.selectedItem + ((30) + random.nextInt(30)),
      duration: Duration(seconds: 3),
      curve: Curves.ease,
    );
  }

// FOR TAGS
  List<Tag> _selectedTags = [];
  List<Tag> get selectedTags => _selectedTags;

  void onPressedTag(Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _slotScreenTagSubject.add(_selectedTags);
  }

  final BehaviorSubject<List<Tag>> _slotScreenTagSubject =
      BehaviorSubject<List<Tag>>.seeded(<Tag>[]);
  Stream<List<Tag>> get streamSlotScreenSelectedTags =>
      _slotScreenTagSubject.stream;
}
