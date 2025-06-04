import 'package:drift_todo/database/app_database.dart';
import 'package:drift_todo/database/dao/tasks_dao.dart';
import 'package:drift_todo/repository/task_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dbProvider = Provider((ref) {
  return AppDatabase();
});

final daoProvider = Provider<TasksDao>(
  (ref) => TasksDao(ref.watch(dbProvider)),
);

final repositoryProvider = Provider(
  (ref) => TaskRepository(ref.watch(daoProvider)),
);

final getAllTasksProvider = StreamProvider<List<Task>>(
  (ref) => ref.watch(repositoryProvider).watchAllTasks(),
);
final selectedTasksProvider = StateProvider<Set<String>>((ref) => {});
final radioGroupValueProvider = StateProvider((ref) => 1);
