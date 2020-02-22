import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:rxdart/rxdart.dart';

import '../services/database_service.dart' as db;

class WriteActionScreenProvider {
  final db.ActionWithTags currentActionWithTags;
  db.AppDatabase _appDatabase;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  String _initialName = '';
  String _initialNote = '';
  List<db.Tag> _initialTags = [];

  TextEditingController get nameController => _nameController;
  TextEditingController get noteController => _noteController;
  FocusNode get nameFocusNode => _nameFocusNode;
  List<db.Tag> get initialTags => [..._initialTags];

  WriteActionScreenProvider({
    this.currentActionWithTags,
  }) {
    _initialName = currentActionWithTags?.action?.name ?? '';
    _initialNote = currentActionWithTags?.action?.note ?? '';
    _initialTags.addAll(currentActionWithTags?.tags ?? []);
    _nameController.text = _initialName;
    _noteController.text = _initialNote;
    _selectedTags = initialTags;
    _writeActionScreenTagSubject.add(initialTags);
  }

  set currentDatabase(db.AppDatabase value) {
    if (_appDatabase != value) {
      _appDatabase = value;
    }
  }

  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    _writeActionScreenTagSubject.close();
    _nameFocusNode.dispose();
    _checkUpdateSubject.close();
  }

  bool isNew() => currentActionWithTags == null;

  bool onPressdButton(BuildContext context, bool isUpdated) =>
      isUpdated ? _updateActionWithTags() : _startEditing(context);

  bool _updateActionWithTags() {
    if (_nameController.text.length >= 1 && _nameController.text.length <= 50) {
      final db.ActionWithTags newActionWithTags = db.ActionWithTags(
        db.Action(
          id: currentActionWithTags?.action?.id,
          name: _nameController.text,
          note: _noteController.text,
        ),
        _writeActionScreenTagSubject.value,
      );
      _appDatabase.insertActionWithTags(newActionWithTags);
      // _nameController.clear();
      // _noteController.clear();
      return true;
    }
    return false;
  }

  bool _startEditing(context) {
    FocusScope.of(context).requestFocus(_nameFocusNode);
    return false;
  }

// For tag
  void onSubmitTag(String tagName) {
    if (tagName.length >= 1 && tagName.length <= 10) {
      final db.TagsCompanion tag = db.TagsCompanion(
        name: Value(tagName),
      );
      _appDatabase.tagDao.insertTag(tag);
    }
  }

  void onRemoveTag(db.Tag tag) => _appDatabase.deleteTag(tag);

  List<db.Tag> _selectedTags = [];

  void onPressedTag(db.Tag tag, bool isSelected) {
    isSelected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
    _writeActionScreenTagSubject.add(_selectedTags);
  }

  final BehaviorSubject<List<db.Tag>> _writeActionScreenTagSubject =
      BehaviorSubject<List<db.Tag>>.seeded(<db.Tag>[]);

  // For button
  final BehaviorSubject<bool> _checkUpdateSubject =
      BehaviorSubject<bool>.seeded(false);
  // Stream<bool> get isUpdated => _checkUpdateSubject.stream;

  // check equallity of the lists
  bool compareTags(List<db.Tag> initialTags, List<db.Tag> currentTags) {
    if (initialTags.length != currentTags.length) return false;
    final sortedInitialTags = initialTags..sort((a, b) => a.id.compareTo(b.id));
    final sortedCurrentTags = currentTags..sort((a, b) => a.id.compareTo(b.id));
    return listEquals(sortedInitialTags, sortedCurrentTags);
  }

  // check textfield update with onChanged
  void checkTextFieldUpdate(String newVal, String field) {
    switch (field) {
      case 'name':
        if (newVal != _initialName) {
          _checkUpdateSubject.add(true);
        } else {
          _checkUpdateSubject.add(false);
        }

        break;
      case 'note':
        if (newVal != _initialNote) {
          _checkUpdateSubject.add(true);
        } else {
          _checkUpdateSubject.add(false);
        }
        break;
      default:
        _checkUpdateSubject.add(false);
    }
  }

  Stream<bool> checkUpdate() {
    return CombineLatestStream.combine2<bool, List<db.Tag>, bool>(
      _checkUpdateSubject.stream,
      _writeActionScreenTagSubject.stream,
      (bool currentStatus, List<db.Tag> tags) {
        if (_initialName != _nameController.text ||
            !compareTags(_initialTags, tags) ||
            _initialNote != _noteController.text) return true;
        return false;
      },
    );
  }
}
