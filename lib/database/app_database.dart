import 'package:drift/drift.dart';
import 'package:drift_todo/database/constructor_db.dart';
import 'package:uuid/uuid.dart';

import 'package:drift_todo/database/tables/tasks.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(constructDb());

  @override
  int get schemaVersion => 1;
}
