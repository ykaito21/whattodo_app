import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/services/database_service.dart';

class AppProvider {
  final AppDatabase _appDatabase = AppDatabase();
  AppDatabase get appDatabase => _appDatabase;

  void dispose() {}

  Stream<List<ActionWithTags>> streamActionWithTags({
    @required Stream<List<Tag>> tags,
    Stream<List<String>> keywords,
  }) {
    final Stream<List<ActionWithTags>> allActionWithTags =
        _appDatabase.streamAllActionWithTags();
    if (keywords == null) {
      return CombineLatestStream.combine2<List<ActionWithTags>, List<Tag>,
          List<ActionWithTags>>(
        allActionWithTags,
        tags,
        (List<ActionWithTags> allActionWithTags, List<Tag> tags) {
          if (tags.isEmpty) return allActionWithTags;
          List<ActionWithTags> actionWithTagsList = [];
          for (var actionWithTags in allActionWithTags) {
            if (tags.any((tag) => actionWithTags.tags.contains(tag))) {
              actionWithTagsList.add(actionWithTags);
            }
          }
          return actionWithTagsList;
        },
      );
    } else {
      return CombineLatestStream.combine3<List<ActionWithTags>, List<Tag>,
          List<String>, List<ActionWithTags>>(
        allActionWithTags,
        tags,
        keywords,
        (List<ActionWithTags> allActionWithTags, List<Tag> tags,
            List<String> keywords) {
          if (tags.isEmpty &&
              (keywords.isEmpty || keywords?.first.isEmpty ?? true))
            return allActionWithTags;
          List<ActionWithTags> actionWithTagsList = [];
          if (tags.isNotEmpty &&
              (keywords.isEmpty || keywords?.first.isEmpty ?? true)) {
            actionWithTagsList.clear();
            for (var actionWithTags in allActionWithTags) {
              if (tags.any((tag) => actionWithTags.tags.contains(tag))) {
                actionWithTagsList.add(actionWithTags);
              }
            }
          }
          if (tags.isEmpty &&
              (keywords.isNotEmpty && keywords?.first.isNotEmpty ?? false)) {
            actionWithTagsList.clear();
            for (var actionWithTags in allActionWithTags) {
              if (keywords.any((keyword) =>
                      actionWithTags.action.name.contains(keyword)) ||
                  keywords.any((keyword) =>
                      actionWithTags.action.note.contains(keyword))) {
                actionWithTagsList.add(actionWithTags);
              }
            }
          }
          if (tags.isNotEmpty &&
              (keywords.isNotEmpty && keywords?.first.isNotEmpty ?? false)) {
            actionWithTagsList.clear();
            for (var actionWithTags in allActionWithTags) {
              if (tags.any((tag) => actionWithTags.tags.contains(tag)) &&
                      keywords.any((keyword) =>
                          actionWithTags.action.name.contains(keyword)) ||
                  keywords.any((keyword) =>
                      actionWithTags.action.note.contains(keyword))) {
                actionWithTagsList.add(actionWithTags);
              }
            }
          }
          return actionWithTagsList;
        },
      );
    }
  }

  Stream<List<Tag>> streamTags() {
    return _appDatabase.tagDao.streamAllTags();
  }

  deleteActionWithTags(ActionWithTags actionWithTags) {
    _appDatabase.deleteActionWithTags(actionWithTags);
  }
}
