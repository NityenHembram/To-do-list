// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TasksListTable extends TasksList
    with TableInfo<$TasksListTable, TasksListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _taskListNameMeta =
      const VerificationMeta('taskListName');
  @override
  late final GeneratedColumn<String> taskListName = GeneratedColumn<String>(
      'task_list_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isDeleteAbleMeta =
      const VerificationMeta('isDeleteAble');
  @override
  late final GeneratedColumn<bool> isDeleteAble = GeneratedColumn<bool>(
      'is_delete_able', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_delete_able" IN (0, 1))'),
      defaultValue: Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, taskListName, isDeleteAble];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_list';
  @override
  VerificationContext validateIntegrity(Insertable<TasksListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_list_name')) {
      context.handle(
          _taskListNameMeta,
          taskListName.isAcceptableOrUnknown(
              data['task_list_name']!, _taskListNameMeta));
    } else if (isInserting) {
      context.missing(_taskListNameMeta);
    }
    if (data.containsKey('is_delete_able')) {
      context.handle(
          _isDeleteAbleMeta,
          isDeleteAble.isAcceptableOrUnknown(
              data['is_delete_able']!, _isDeleteAbleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasksListData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskListName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_list_name'])!,
      isDeleteAble: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_delete_able'])!,
    );
  }

  @override
  $TasksListTable createAlias(String alias) {
    return $TasksListTable(attachedDatabase, alias);
  }
}

class TasksListData extends DataClass implements Insertable<TasksListData> {
  final int id;
  final String taskListName;
  final bool isDeleteAble;
  const TasksListData(
      {required this.id,
      required this.taskListName,
      required this.isDeleteAble});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_list_name'] = Variable<String>(taskListName);
    map['is_delete_able'] = Variable<bool>(isDeleteAble);
    return map;
  }

  TasksListCompanion toCompanion(bool nullToAbsent) {
    return TasksListCompanion(
      id: Value(id),
      taskListName: Value(taskListName),
      isDeleteAble: Value(isDeleteAble),
    );
  }

  factory TasksListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasksListData(
      id: serializer.fromJson<int>(json['id']),
      taskListName: serializer.fromJson<String>(json['taskListName']),
      isDeleteAble: serializer.fromJson<bool>(json['isDeleteAble']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskListName': serializer.toJson<String>(taskListName),
      'isDeleteAble': serializer.toJson<bool>(isDeleteAble),
    };
  }

  TasksListData copyWith({int? id, String? taskListName, bool? isDeleteAble}) =>
      TasksListData(
        id: id ?? this.id,
        taskListName: taskListName ?? this.taskListName,
        isDeleteAble: isDeleteAble ?? this.isDeleteAble,
      );
  TasksListData copyWithCompanion(TasksListCompanion data) {
    return TasksListData(
      id: data.id.present ? data.id.value : this.id,
      taskListName: data.taskListName.present
          ? data.taskListName.value
          : this.taskListName,
      isDeleteAble: data.isDeleteAble.present
          ? data.isDeleteAble.value
          : this.isDeleteAble,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasksListData(')
          ..write('id: $id, ')
          ..write('taskListName: $taskListName, ')
          ..write('isDeleteAble: $isDeleteAble')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskListName, isDeleteAble);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksListData &&
          other.id == this.id &&
          other.taskListName == this.taskListName &&
          other.isDeleteAble == this.isDeleteAble);
}

class TasksListCompanion extends UpdateCompanion<TasksListData> {
  final Value<int> id;
  final Value<String> taskListName;
  final Value<bool> isDeleteAble;
  const TasksListCompanion({
    this.id = const Value.absent(),
    this.taskListName = const Value.absent(),
    this.isDeleteAble = const Value.absent(),
  });
  TasksListCompanion.insert({
    this.id = const Value.absent(),
    required String taskListName,
    this.isDeleteAble = const Value.absent(),
  }) : taskListName = Value(taskListName);
  static Insertable<TasksListData> custom({
    Expression<int>? id,
    Expression<String>? taskListName,
    Expression<bool>? isDeleteAble,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskListName != null) 'task_list_name': taskListName,
      if (isDeleteAble != null) 'is_delete_able': isDeleteAble,
    });
  }

  TasksListCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskListName,
      Value<bool>? isDeleteAble}) {
    return TasksListCompanion(
      id: id ?? this.id,
      taskListName: taskListName ?? this.taskListName,
      isDeleteAble: isDeleteAble ?? this.isDeleteAble,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskListName.present) {
      map['task_list_name'] = Variable<String>(taskListName.value);
    }
    if (isDeleteAble.present) {
      map['is_delete_able'] = Variable<bool>(isDeleteAble.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksListCompanion(')
          ..write('id: $id, ')
          ..write('taskListName: $taskListName, ')
          ..write('isDeleteAble: $isDeleteAble')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _taskDateTimeMeta =
      const VerificationMeta('taskDateTime');
  @override
  late final GeneratedColumn<DateTime> taskDateTime = GeneratedColumn<DateTime>(
      'task_date_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(1));
  static const VerificationMeta _taskListIdMeta =
      const VerificationMeta('taskListId');
  @override
  late final GeneratedColumn<int> taskListId = GeneratedColumn<int>(
      'task_list_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tasks_list(id) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, complete, taskDateTime, priority, taskListId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    if (data.containsKey('task_date_time')) {
      context.handle(
          _taskDateTimeMeta,
          taskDateTime.isAcceptableOrUnknown(
              data['task_date_time']!, _taskDateTimeMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('task_list_id')) {
      context.handle(
          _taskListIdMeta,
          taskListId.isAcceptableOrUnknown(
              data['task_list_id']!, _taskListIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      taskDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}task_date_time']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      taskListId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_list_id']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final bool complete;
  final DateTime? taskDateTime;
  final int priority;
  final int? taskListId;
  const Task(
      {required this.id,
      required this.title,
      required this.complete,
      this.taskDateTime,
      required this.priority,
      this.taskListId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['complete'] = Variable<bool>(complete);
    if (!nullToAbsent || taskDateTime != null) {
      map['task_date_time'] = Variable<DateTime>(taskDateTime);
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || taskListId != null) {
      map['task_list_id'] = Variable<int>(taskListId);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      complete: Value(complete),
      taskDateTime: taskDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(taskDateTime),
      priority: Value(priority),
      taskListId: taskListId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskListId),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      complete: serializer.fromJson<bool>(json['complete']),
      taskDateTime: serializer.fromJson<DateTime?>(json['taskDateTime']),
      priority: serializer.fromJson<int>(json['priority']),
      taskListId: serializer.fromJson<int?>(json['taskListId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'complete': serializer.toJson<bool>(complete),
      'taskDateTime': serializer.toJson<DateTime?>(taskDateTime),
      'priority': serializer.toJson<int>(priority),
      'taskListId': serializer.toJson<int?>(taskListId),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          bool? complete,
          Value<DateTime?> taskDateTime = const Value.absent(),
          int? priority,
          Value<int?> taskListId = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        complete: complete ?? this.complete,
        taskDateTime:
            taskDateTime.present ? taskDateTime.value : this.taskDateTime,
        priority: priority ?? this.priority,
        taskListId: taskListId.present ? taskListId.value : this.taskListId,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      complete: data.complete.present ? data.complete.value : this.complete,
      taskDateTime: data.taskDateTime.present
          ? data.taskDateTime.value
          : this.taskDateTime,
      priority: data.priority.present ? data.priority.value : this.priority,
      taskListId:
          data.taskListId.present ? data.taskListId.value : this.taskListId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('complete: $complete, ')
          ..write('taskDateTime: $taskDateTime, ')
          ..write('priority: $priority, ')
          ..write('taskListId: $taskListId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, complete, taskDateTime, priority, taskListId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.complete == this.complete &&
          other.taskDateTime == this.taskDateTime &&
          other.priority == this.priority &&
          other.taskListId == this.taskListId);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> complete;
  final Value<DateTime?> taskDateTime;
  final Value<int> priority;
  final Value<int?> taskListId;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.complete = const Value.absent(),
    this.taskDateTime = const Value.absent(),
    this.priority = const Value.absent(),
    this.taskListId = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.complete = const Value.absent(),
    this.taskDateTime = const Value.absent(),
    this.priority = const Value.absent(),
    this.taskListId = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? complete,
    Expression<DateTime>? taskDateTime,
    Expression<int>? priority,
    Expression<int>? taskListId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (complete != null) 'complete': complete,
      if (taskDateTime != null) 'task_date_time': taskDateTime,
      if (priority != null) 'priority': priority,
      if (taskListId != null) 'task_list_id': taskListId,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? complete,
      Value<DateTime?>? taskDateTime,
      Value<int>? priority,
      Value<int?>? taskListId}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      complete: complete ?? this.complete,
      taskDateTime: taskDateTime ?? this.taskDateTime,
      priority: priority ?? this.priority,
      taskListId: taskListId ?? this.taskListId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (taskDateTime.present) {
      map['task_date_time'] = Variable<DateTime>(taskDateTime.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (taskListId.present) {
      map['task_list_id'] = Variable<int>(taskListId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('complete: $complete, ')
          ..write('taskDateTime: $taskDateTime, ')
          ..write('priority: $priority, ')
          ..write('taskListId: $taskListId')
          ..write(')'))
        .toString();
  }
}

class $FinishedTaskTableTable extends FinishedTaskTable
    with TableInfo<$FinishedTaskTableTable, FinishedTaskTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinishedTaskTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: Constant(false));
  static const VerificationMeta _taskDateTimeMeta =
      const VerificationMeta('taskDateTime');
  @override
  late final GeneratedColumn<DateTime> taskDateTime = GeneratedColumn<DateTime>(
      'task_date_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(1));
  static const VerificationMeta _taskListIdMeta =
      const VerificationMeta('taskListId');
  @override
  late final GeneratedColumn<int> taskListId = GeneratedColumn<int>(
      'task_list_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES tasks_list(id) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, complete, taskDateTime, priority, taskListId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finished_task_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FinishedTaskTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    if (data.containsKey('task_date_time')) {
      context.handle(
          _taskDateTimeMeta,
          taskDateTime.isAcceptableOrUnknown(
              data['task_date_time']!, _taskDateTimeMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('task_list_id')) {
      context.handle(
          _taskListIdMeta,
          taskListId.isAcceptableOrUnknown(
              data['task_list_id']!, _taskListIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinishedTaskTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinishedTaskTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      taskDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}task_date_time']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      taskListId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_list_id']),
    );
  }

  @override
  $FinishedTaskTableTable createAlias(String alias) {
    return $FinishedTaskTableTable(attachedDatabase, alias);
  }
}

class FinishedTaskTableData extends DataClass
    implements Insertable<FinishedTaskTableData> {
  final int id;
  final String title;
  final bool complete;
  final DateTime? taskDateTime;
  final int priority;
  final int? taskListId;
  const FinishedTaskTableData(
      {required this.id,
      required this.title,
      required this.complete,
      this.taskDateTime,
      required this.priority,
      this.taskListId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['complete'] = Variable<bool>(complete);
    if (!nullToAbsent || taskDateTime != null) {
      map['task_date_time'] = Variable<DateTime>(taskDateTime);
    }
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || taskListId != null) {
      map['task_list_id'] = Variable<int>(taskListId);
    }
    return map;
  }

  FinishedTaskTableCompanion toCompanion(bool nullToAbsent) {
    return FinishedTaskTableCompanion(
      id: Value(id),
      title: Value(title),
      complete: Value(complete),
      taskDateTime: taskDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(taskDateTime),
      priority: Value(priority),
      taskListId: taskListId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskListId),
    );
  }

  factory FinishedTaskTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinishedTaskTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      complete: serializer.fromJson<bool>(json['complete']),
      taskDateTime: serializer.fromJson<DateTime?>(json['taskDateTime']),
      priority: serializer.fromJson<int>(json['priority']),
      taskListId: serializer.fromJson<int?>(json['taskListId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'complete': serializer.toJson<bool>(complete),
      'taskDateTime': serializer.toJson<DateTime?>(taskDateTime),
      'priority': serializer.toJson<int>(priority),
      'taskListId': serializer.toJson<int?>(taskListId),
    };
  }

  FinishedTaskTableData copyWith(
          {int? id,
          String? title,
          bool? complete,
          Value<DateTime?> taskDateTime = const Value.absent(),
          int? priority,
          Value<int?> taskListId = const Value.absent()}) =>
      FinishedTaskTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        complete: complete ?? this.complete,
        taskDateTime:
            taskDateTime.present ? taskDateTime.value : this.taskDateTime,
        priority: priority ?? this.priority,
        taskListId: taskListId.present ? taskListId.value : this.taskListId,
      );
  FinishedTaskTableData copyWithCompanion(FinishedTaskTableCompanion data) {
    return FinishedTaskTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      complete: data.complete.present ? data.complete.value : this.complete,
      taskDateTime: data.taskDateTime.present
          ? data.taskDateTime.value
          : this.taskDateTime,
      priority: data.priority.present ? data.priority.value : this.priority,
      taskListId:
          data.taskListId.present ? data.taskListId.value : this.taskListId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinishedTaskTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('complete: $complete, ')
          ..write('taskDateTime: $taskDateTime, ')
          ..write('priority: $priority, ')
          ..write('taskListId: $taskListId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, complete, taskDateTime, priority, taskListId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinishedTaskTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.complete == this.complete &&
          other.taskDateTime == this.taskDateTime &&
          other.priority == this.priority &&
          other.taskListId == this.taskListId);
}

class FinishedTaskTableCompanion
    extends UpdateCompanion<FinishedTaskTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> complete;
  final Value<DateTime?> taskDateTime;
  final Value<int> priority;
  final Value<int?> taskListId;
  const FinishedTaskTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.complete = const Value.absent(),
    this.taskDateTime = const Value.absent(),
    this.priority = const Value.absent(),
    this.taskListId = const Value.absent(),
  });
  FinishedTaskTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.complete = const Value.absent(),
    this.taskDateTime = const Value.absent(),
    this.priority = const Value.absent(),
    this.taskListId = const Value.absent(),
  }) : title = Value(title);
  static Insertable<FinishedTaskTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? complete,
    Expression<DateTime>? taskDateTime,
    Expression<int>? priority,
    Expression<int>? taskListId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (complete != null) 'complete': complete,
      if (taskDateTime != null) 'task_date_time': taskDateTime,
      if (priority != null) 'priority': priority,
      if (taskListId != null) 'task_list_id': taskListId,
    });
  }

  FinishedTaskTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? complete,
      Value<DateTime?>? taskDateTime,
      Value<int>? priority,
      Value<int?>? taskListId}) {
    return FinishedTaskTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      complete: complete ?? this.complete,
      taskDateTime: taskDateTime ?? this.taskDateTime,
      priority: priority ?? this.priority,
      taskListId: taskListId ?? this.taskListId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (taskDateTime.present) {
      map['task_date_time'] = Variable<DateTime>(taskDateTime.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (taskListId.present) {
      map['task_list_id'] = Variable<int>(taskListId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinishedTaskTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('complete: $complete, ')
          ..write('taskDateTime: $taskDateTime, ')
          ..write('priority: $priority, ')
          ..write('taskListId: $taskListId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksListTable tasksList = $TasksListTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $FinishedTaskTableTable finishedTaskTable =
      $FinishedTaskTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasksList, tasks, finishedTaskTable];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('tasks_list',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tasks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tasks_list',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('finished_task_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$TasksListTableCreateCompanionBuilder = TasksListCompanion Function({
  Value<int> id,
  required String taskListName,
  Value<bool> isDeleteAble,
});
typedef $$TasksListTableUpdateCompanionBuilder = TasksListCompanion Function({
  Value<int> id,
  Value<String> taskListName,
  Value<bool> isDeleteAble,
});

final class $$TasksListTableReferences
    extends BaseReferences<_$AppDatabase, $TasksListTable, TasksListData> {
  $$TasksListTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tasks,
          aliasName:
              $_aliasNameGenerator(db.tasksList.id, db.tasks.taskListId));

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.taskListId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FinishedTaskTableTable,
      List<FinishedTaskTableData>> _finishedTaskTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.finishedTaskTable,
          aliasName: $_aliasNameGenerator(
              db.tasksList.id, db.finishedTaskTable.taskListId));

  $$FinishedTaskTableTableProcessedTableManager get finishedTaskTableRefs {
    final manager =
        $$FinishedTaskTableTableTableManager($_db, $_db.finishedTaskTable)
            .filter((f) => f.taskListId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_finishedTaskTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TasksListTableFilterComposer
    extends Composer<_$AppDatabase, $TasksListTable> {
  $$TasksListTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskListName => $composableBuilder(
      column: $table.taskListName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleteAble => $composableBuilder(
      column: $table.isDeleteAble, builder: (column) => ColumnFilters(column));

  Expression<bool> tasksRefs(
      Expression<bool> Function($$TasksTableFilterComposer f) f) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.taskListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> finishedTaskTableRefs(
      Expression<bool> Function($$FinishedTaskTableTableFilterComposer f) f) {
    final $$FinishedTaskTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.finishedTaskTable,
        getReferencedColumn: (t) => t.taskListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FinishedTaskTableTableFilterComposer(
              $db: $db,
              $table: $db.finishedTaskTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksListTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksListTable> {
  $$TasksListTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskListName => $composableBuilder(
      column: $table.taskListName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleteAble => $composableBuilder(
      column: $table.isDeleteAble,
      builder: (column) => ColumnOrderings(column));
}

class $$TasksListTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksListTable> {
  $$TasksListTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskListName => $composableBuilder(
      column: $table.taskListName, builder: (column) => column);

  GeneratedColumn<bool> get isDeleteAble => $composableBuilder(
      column: $table.isDeleteAble, builder: (column) => column);

  Expression<T> tasksRefs<T extends Object>(
      Expression<T> Function($$TasksTableAnnotationComposer a) f) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.taskListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> finishedTaskTableRefs<T extends Object>(
      Expression<T> Function($$FinishedTaskTableTableAnnotationComposer a) f) {
    final $$FinishedTaskTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.finishedTaskTable,
            getReferencedColumn: (t) => t.taskListId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FinishedTaskTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.finishedTaskTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$TasksListTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksListTable,
    TasksListData,
    $$TasksListTableFilterComposer,
    $$TasksListTableOrderingComposer,
    $$TasksListTableAnnotationComposer,
    $$TasksListTableCreateCompanionBuilder,
    $$TasksListTableUpdateCompanionBuilder,
    (TasksListData, $$TasksListTableReferences),
    TasksListData,
    PrefetchHooks Function({bool tasksRefs, bool finishedTaskTableRefs})> {
  $$TasksListTableTableManager(_$AppDatabase db, $TasksListTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksListTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksListTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksListTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> taskListName = const Value.absent(),
            Value<bool> isDeleteAble = const Value.absent(),
          }) =>
              TasksListCompanion(
            id: id,
            taskListName: taskListName,
            isDeleteAble: isDeleteAble,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String taskListName,
            Value<bool> isDeleteAble = const Value.absent(),
          }) =>
              TasksListCompanion.insert(
            id: id,
            taskListName: taskListName,
            isDeleteAble: isDeleteAble,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TasksListTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tasksRefs = false, finishedTaskTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tasksRefs) db.tasks,
                if (finishedTaskTableRefs) db.finishedTaskTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TasksListTableReferences._tasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksListTableReferences(db, table, p0).tasksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.taskListId == item.id),
                        typedResults: items),
                  if (finishedTaskTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$TasksListTableReferences
                            ._finishedTaskTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksListTableReferences(db, table, p0)
                                .finishedTaskTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.taskListId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TasksListTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksListTable,
    TasksListData,
    $$TasksListTableFilterComposer,
    $$TasksListTableOrderingComposer,
    $$TasksListTableAnnotationComposer,
    $$TasksListTableCreateCompanionBuilder,
    $$TasksListTableUpdateCompanionBuilder,
    (TasksListData, $$TasksListTableReferences),
    TasksListData,
    PrefetchHooks Function({bool tasksRefs, bool finishedTaskTableRefs})>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  Value<bool> complete,
  Value<DateTime?> taskDateTime,
  Value<int> priority,
  Value<int?> taskListId,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<bool> complete,
  Value<DateTime?> taskDateTime,
  Value<int> priority,
  Value<int?> taskListId,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksListTable _taskListIdTable(_$AppDatabase db) => db.tasksList
      .createAlias($_aliasNameGenerator(db.tasks.taskListId, db.tasksList.id));

  $$TasksListTableProcessedTableManager? get taskListId {
    if ($_item.taskListId == null) return null;
    final manager = $$TasksListTableTableManager($_db, $_db.tasksList)
        .filter((f) => f.id($_item.taskListId!));
    final item = $_typedResult.readTableOrNull(_taskListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  $$TasksListTableFilterComposer get taskListId {
    final $$TasksListTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableFilterComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  $$TasksListTableOrderingComposer get taskListId {
    final $$TasksListTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableOrderingComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get complete =>
      $composableBuilder(column: $table.complete, builder: (column) => column);

  GeneratedColumn<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$TasksListTableAnnotationComposer get taskListId {
    final $$TasksListTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableAnnotationComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool taskListId})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> complete = const Value.absent(),
            Value<DateTime?> taskDateTime = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int?> taskListId = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            complete: complete,
            taskDateTime: taskDateTime,
            priority: priority,
            taskListId: taskListId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<bool> complete = const Value.absent(),
            Value<DateTime?> taskDateTime = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int?> taskListId = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            complete: complete,
            taskDateTime: taskDateTime,
            priority: priority,
            taskListId: taskListId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({taskListId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskListId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskListId,
                    referencedTable:
                        $$TasksTableReferences._taskListIdTable(db),
                    referencedColumn:
                        $$TasksTableReferences._taskListIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool taskListId})>;
typedef $$FinishedTaskTableTableCreateCompanionBuilder
    = FinishedTaskTableCompanion Function({
  Value<int> id,
  required String title,
  Value<bool> complete,
  Value<DateTime?> taskDateTime,
  Value<int> priority,
  Value<int?> taskListId,
});
typedef $$FinishedTaskTableTableUpdateCompanionBuilder
    = FinishedTaskTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<bool> complete,
  Value<DateTime?> taskDateTime,
  Value<int> priority,
  Value<int?> taskListId,
});

final class $$FinishedTaskTableTableReferences extends BaseReferences<
    _$AppDatabase, $FinishedTaskTableTable, FinishedTaskTableData> {
  $$FinishedTaskTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TasksListTable _taskListIdTable(_$AppDatabase db) =>
      db.tasksList.createAlias($_aliasNameGenerator(
          db.finishedTaskTable.taskListId, db.tasksList.id));

  $$TasksListTableProcessedTableManager? get taskListId {
    if ($_item.taskListId == null) return null;
    final manager = $$TasksListTableTableManager($_db, $_db.tasksList)
        .filter((f) => f.id($_item.taskListId!));
    final item = $_typedResult.readTableOrNull(_taskListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FinishedTaskTableTableFilterComposer
    extends Composer<_$AppDatabase, $FinishedTaskTableTable> {
  $$FinishedTaskTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  $$TasksListTableFilterComposer get taskListId {
    final $$TasksListTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableFilterComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FinishedTaskTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FinishedTaskTableTable> {
  $$FinishedTaskTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get complete => $composableBuilder(
      column: $table.complete, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  $$TasksListTableOrderingComposer get taskListId {
    final $$TasksListTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableOrderingComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FinishedTaskTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinishedTaskTableTable> {
  $$FinishedTaskTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get complete =>
      $composableBuilder(column: $table.complete, builder: (column) => column);

  GeneratedColumn<DateTime> get taskDateTime => $composableBuilder(
      column: $table.taskDateTime, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  $$TasksListTableAnnotationComposer get taskListId {
    final $$TasksListTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskListId,
        referencedTable: $db.tasksList,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksListTableAnnotationComposer(
              $db: $db,
              $table: $db.tasksList,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FinishedTaskTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FinishedTaskTableTable,
    FinishedTaskTableData,
    $$FinishedTaskTableTableFilterComposer,
    $$FinishedTaskTableTableOrderingComposer,
    $$FinishedTaskTableTableAnnotationComposer,
    $$FinishedTaskTableTableCreateCompanionBuilder,
    $$FinishedTaskTableTableUpdateCompanionBuilder,
    (FinishedTaskTableData, $$FinishedTaskTableTableReferences),
    FinishedTaskTableData,
    PrefetchHooks Function({bool taskListId})> {
  $$FinishedTaskTableTableTableManager(
      _$AppDatabase db, $FinishedTaskTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinishedTaskTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinishedTaskTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinishedTaskTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<bool> complete = const Value.absent(),
            Value<DateTime?> taskDateTime = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int?> taskListId = const Value.absent(),
          }) =>
              FinishedTaskTableCompanion(
            id: id,
            title: title,
            complete: complete,
            taskDateTime: taskDateTime,
            priority: priority,
            taskListId: taskListId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<bool> complete = const Value.absent(),
            Value<DateTime?> taskDateTime = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int?> taskListId = const Value.absent(),
          }) =>
              FinishedTaskTableCompanion.insert(
            id: id,
            title: title,
            complete: complete,
            taskDateTime: taskDateTime,
            priority: priority,
            taskListId: taskListId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FinishedTaskTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskListId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskListId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskListId,
                    referencedTable:
                        $$FinishedTaskTableTableReferences._taskListIdTable(db),
                    referencedColumn: $$FinishedTaskTableTableReferences
                        ._taskListIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FinishedTaskTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FinishedTaskTableTable,
    FinishedTaskTableData,
    $$FinishedTaskTableTableFilterComposer,
    $$FinishedTaskTableTableOrderingComposer,
    $$FinishedTaskTableTableAnnotationComposer,
    $$FinishedTaskTableTableCreateCompanionBuilder,
    $$FinishedTaskTableTableUpdateCompanionBuilder,
    (FinishedTaskTableData, $$FinishedTaskTableTableReferences),
    FinishedTaskTableData,
    PrefetchHooks Function({bool taskListId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksListTableTableManager get tasksList =>
      $$TasksListTableTableManager(_db, _db.tasksList);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$FinishedTaskTableTableTableManager get finishedTaskTable =>
      $$FinishedTaskTableTableTableManager(_db, _db.finishedTaskTable);
}
