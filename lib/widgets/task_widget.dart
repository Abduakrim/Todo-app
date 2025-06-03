// ignore_for_file: deprecated_member_use

import 'package:drift_todo/database/app_database.dart';
import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskWidget extends HookConsumerWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTasksProvider);
    final isSelected = selected.contains(task.id);

    return GestureDetector(
      onLongPress:
          selected.isEmpty
              ? () {
                final notifier = ref.read(selectedTasksProvider.notifier);
                final current = notifier.state;
                if (current.contains(task.id)) {
                  notifier.state = {...current}..remove(task.id);
                } else {
                  notifier.state = {...current}..add(task.id);
                }
              }
              : () {},
      onTap:
          selected.isNotEmpty
              ? () {
                final notifier = ref.read(selectedTasksProvider.notifier);
                final current = notifier.state;
                if (current.contains(task.id)) {
                  notifier.state = {...current}..remove(task.id);
                } else {
                  notifier.state = {...current}..add(task.id);
                }
              }
              : () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: isSelected ? Colors.green : Colors.green.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Checkbox(
                  value: task.isDone,
                  onChanged:
                      (value) => ref
                          .read(repositoryProvider)
                          .toggleTask(id: task.id, value: value!),
                ),
                Column(
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 76, 76, 76),
                      ),
                    ),

                    task.description == ''
                        ? SizedBox()
                        : Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            task.description!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 76, 76, 76),
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ),

            if (isSelected)
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
