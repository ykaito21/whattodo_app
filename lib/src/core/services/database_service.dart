import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
// import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';

part 'database_service.g.dart';

class Actions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get note => text().nullable()();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
}

class Taggings extends Table {
  IntColumn get actionId =>
      integer().customConstraint('NOT NULL REFERENCES actions(id)')();
  IntColumn get tagId =>
      integer().customConstraint('NOT NULL REFERENCES tags(id)')();
  @override
  Set<Column> get primaryKey => {actionId, tagId};
}

class ActionWithTags {
  final Action action;
  final List<Tag> tags;

  ActionWithTags(this.action, this.tags);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Actions, Tags, Taggings], daos: [ActionDao, TagDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  // AppDatabase()
  //     : super((FlutterQueryExecutor.inDatabaseFolder(
  //         path: 'db.sqlite',
  //         logStatements: true,
  //       )));

  @override
  int get schemaVersion => 1;

  Stream<List<ActionWithTags>> streamAllActionWithTags() {
    final Stream<List<Action>> actionStream = select(actions).watch();
    return actionStream.switchMap(
      (actions) {
        final Map<int, Action> idToAction = {
          for (var action in actions) action.id: action
        };
        final Iterable<int> ids = idToAction.keys;

        final entryQuery = select(taggings).join(
          [
            innerJoin(
              tags,
              tags.id.equalsExp(taggings.tagId),
            )
          ],
        )..where(taggings.actionId.isIn(ids));

        return entryQuery.watch().map(
          (rows) {
            final idToTags = <int, List<Tag>>{};

            for (var row in rows) {
              final Tag tag = row.readTable(tags);
              final int id = row.readTable(taggings).actionId;

              idToTags.putIfAbsent(id, () => []).add(tag);
            }

            return [
              for (var id in ids)
                ActionWithTags(idToAction[id], idToTags[id] ?? []),
            ];
          },
        );
      },
    );
  }

  void insertActionWithTags(ActionWithTags actionWithTags) {
    transaction(
      () async {
        final Insertable<Action> action = actionWithTags.action;
        final int actionId =
            await into(actions).insert(action, orReplace: true);

        // deltet all previous taggings
        await (delete(taggings)
              ..where((tagging) => tagging.actionId.equals(actionId)))
            .go();
        //add all new taggings
        await batch(
          (batch) {
            batch.insertAll(
              taggings,
              [
                for (var tag in actionWithTags.tags)
                  Tagging(actionId: actionId, tagId: tag.id)
              ],
            );
          },
        );
      },
    );
  }

  void deleteActionWithTags(ActionWithTags actionWithTags) {
    transaction(
      () async {
        final Action action = actionWithTags.action;
        await delete(actions).delete(action);
        // deltet all taggings
        await (delete(taggings)
              ..where((tagging) => tagging.actionId.equals(action.id)))
            .go();
      },
    );
  }

  void deleteTag(Tag tag) {
    transaction(
      () async {
        await delete(tags).delete(tag);
        // deltet all taggings
        await (delete(taggings)
              ..where((tagging) => tagging.tagId.equals(tag.id)))
            .go();
      },
    );
  }
}

@UseDao(tables: [Actions])
class ActionDao extends DatabaseAccessor<AppDatabase> with _$ActionDaoMixin {
  final AppDatabase db;
  ActionDao(this.db) : super(db);
}

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;
  TagDao(this.db) : super(db);

  Stream<List<Tag>> streamAllTags() => select(tags).watch();
  void insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
}
