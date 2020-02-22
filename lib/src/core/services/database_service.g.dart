// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Action extends DataClass implements Insertable<Action> {
  final int id;
  final String name;
  final String note;
  Action({@required this.id, @required this.name, this.note});
  factory Action.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Action(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
    );
  }
  factory Action.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Action(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'note': serializer.toJson<String>(note),
    };
  }

  @override
  ActionsCompanion createCompanion(bool nullToAbsent) {
    return ActionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  Action copyWith({int id, String name, String note}) => Action(
        id: id ?? this.id,
        name: name ?? this.name,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('Action(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, note.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Action &&
          other.id == this.id &&
          other.name == this.name &&
          other.note == this.note);
}

class ActionsCompanion extends UpdateCompanion<Action> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> note;
  const ActionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.note = const Value.absent(),
  });
  ActionsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.note = const Value.absent(),
  }) : name = Value(name);
  ActionsCompanion copyWith(
      {Value<int> id, Value<String> name, Value<String> note}) {
    return ActionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
    );
  }
}

class $ActionsTable extends Actions with TableInfo<$ActionsTable, Action> {
  final GeneratedDatabase _db;
  final String _alias;
  $ActionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn(
      'note',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, note];
  @override
  $ActionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'actions';
  @override
  final String actualTableName = 'actions';
  @override
  VerificationContext validateIntegrity(ActionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.note.present) {
      context.handle(
          _noteMeta, note.isAcceptableValue(d.note.value, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Action map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Action.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ActionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.note.present) {
      map['note'] = Variable<String, StringType>(d.note.value);
    }
    return map;
  }

  @override
  $ActionsTable createAlias(String alias) {
    return $ActionsTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  Tag({@required this.id, @required this.name});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  Tag copyWith({int id, String name}) => Tag(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
  }) : name = Value(name);
  TagsCompanion copyWith({Value<int> id, Value<String> name}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 20);
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class Tagging extends DataClass implements Insertable<Tagging> {
  final int actionId;
  final int tagId;
  Tagging({@required this.actionId, @required this.tagId});
  factory Tagging.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Tagging(
      actionId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}action_id']),
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
    );
  }
  factory Tagging.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Tagging(
      actionId: serializer.fromJson<int>(json['actionId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'actionId': serializer.toJson<int>(actionId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  @override
  TaggingsCompanion createCompanion(bool nullToAbsent) {
    return TaggingsCompanion(
      actionId: actionId == null && nullToAbsent
          ? const Value.absent()
          : Value(actionId),
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
    );
  }

  Tagging copyWith({int actionId, int tagId}) => Tagging(
        actionId: actionId ?? this.actionId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('Tagging(')
          ..write('actionId: $actionId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(actionId.hashCode, tagId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Tagging &&
          other.actionId == this.actionId &&
          other.tagId == this.tagId);
}

class TaggingsCompanion extends UpdateCompanion<Tagging> {
  final Value<int> actionId;
  final Value<int> tagId;
  const TaggingsCompanion({
    this.actionId = const Value.absent(),
    this.tagId = const Value.absent(),
  });
  TaggingsCompanion.insert({
    @required int actionId,
    @required int tagId,
  })  : actionId = Value(actionId),
        tagId = Value(tagId);
  TaggingsCompanion copyWith({Value<int> actionId, Value<int> tagId}) {
    return TaggingsCompanion(
      actionId: actionId ?? this.actionId,
      tagId: tagId ?? this.tagId,
    );
  }
}

class $TaggingsTable extends Taggings with TableInfo<$TaggingsTable, Tagging> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaggingsTable(this._db, [this._alias]);
  final VerificationMeta _actionIdMeta = const VerificationMeta('actionId');
  GeneratedIntColumn _actionId;
  @override
  GeneratedIntColumn get actionId => _actionId ??= _constructActionId();
  GeneratedIntColumn _constructActionId() {
    return GeneratedIntColumn('action_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES actions(id)');
  }

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedIntColumn _tagId;
  @override
  GeneratedIntColumn get tagId => _tagId ??= _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn('tag_id', $tableName, false,
        $customConstraints: 'NOT NULL REFERENCES tags(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [actionId, tagId];
  @override
  $TaggingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taggings';
  @override
  final String actualTableName = 'taggings';
  @override
  VerificationContext validateIntegrity(TaggingsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.actionId.present) {
      context.handle(_actionIdMeta,
          actionId.isAcceptableValue(d.actionId.value, _actionIdMeta));
    } else if (isInserting) {
      context.missing(_actionIdMeta);
    }
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {actionId, tagId};
  @override
  Tagging map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tagging.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TaggingsCompanion d) {
    final map = <String, Variable>{};
    if (d.actionId.present) {
      map['action_id'] = Variable<int, IntType>(d.actionId.value);
    }
    if (d.tagId.present) {
      map['tag_id'] = Variable<int, IntType>(d.tagId.value);
    }
    return map;
  }

  @override
  $TaggingsTable createAlias(String alias) {
    return $TaggingsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ActionsTable _actions;
  $ActionsTable get actions => _actions ??= $ActionsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $TaggingsTable _taggings;
  $TaggingsTable get taggings => _taggings ??= $TaggingsTable(this);
  ActionDao _actionDao;
  ActionDao get actionDao => _actionDao ??= ActionDao(this as AppDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [actions, tags, taggings];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ActionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ActionsTable get actions => db.actions;
}
mixin _$TagDaoMixin on DatabaseAccessor<AppDatabase> {
  $TagsTable get tags => db.tags;
}
