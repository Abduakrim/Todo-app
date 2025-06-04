import 'package:drift/drift.dart';
import 'package:drift_todo/database/app_database.dart';
import 'package:drift_todo/database/tables/tasks.dart';
part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(super.db);
  Stream<List<Task>> watchAllTasks() {
    return select(tasks).watch();
  }

  Future<void> insertTask(TasksCompanion task) {
    return into(tasks).insert(task);
  }

  Future<void> deleteTask(String id) {
    final query = delete(tasks)..where((t) => t.id.equals(id));
    return query.go();
  }

  Future<void> toggleTask(String id, bool value) {
    return (update(tasks)..where(
      (t) => t.id.equals(id),
    )).write(TasksCompanion(isDone: Value(value)));
  }

  Future<void> editTask({
    required String title,
    required String? description,
    required String id,
    required int importance,
  }) {
    return (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        title: Value(title),
        description: Value(description ?? ''),
        importance: Value(importance),
      ),
    );
  }
}
