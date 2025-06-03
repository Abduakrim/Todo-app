import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Tasks extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isDone => boolean().clientDefault(() => false)();
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
  IntColumn get importance => integer().clientDefault(() => 1,)();
  @override
  Set<Column> get primaryKey => {id};
}
