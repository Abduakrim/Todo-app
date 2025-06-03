import 'package:drift/drift.dart';
import 'package:drift_todo/database/app_database.dart';
import 'package:drift_todo/database/dao/tasks_dao.dart';

class TaskRepository {
  final TasksDao _dao;
  TaskRepository(this._dao);
  Stream<List<Task>> watchAllTasks() {
    return _dao.watchAllTasks();
  }

  Future<void> addTask({
    required String title,
    String? description,
    int importance = 1,
  }) async {
    final newTask = TasksCompanion(
      title: Value(title),
      description: Value(description ?? ''),
      importance: Value(importance),
    );
    return _dao.insertTask(newTask);
  }

  Future<void> deleteTask({required String id}) {
    return _dao.deleteTask(id);
  }

  Future<void> toggleTask({required String id, required bool value}) async {
    return _dao.toggleTask(id, value);
  }
}
