// ignore_for_file: deprecated_member_use

import 'package:drift_todo/database/app_database.dart';
import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:drift_todo/widgets/task_alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskWidget extends HookConsumerWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTasksProvider);
    final isSelected = selected.contains(task.id);
    final titleTextController = useTextEditingController();
    final descriptionTextController = useTextEditingController();
    final importance = task.importance;
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
          color:
              importance == 0
                  ? Colors.blue.withOpacity(0.2)
                  : importance == 1
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
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
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 76, 76, 76),
                        ),
                      ),

                      if (task.description != '')
                        Container(
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
                ),
              ],
            ),
            if (isSelected == false)
              Positioned(
                right: 0,
                bottom: -5,

                child: IconButton(
                  onPressed: () {
                    titleTextController.text = task.title;
                    descriptionTextController.text = task.description ?? '';
                    showDialog(
                      context: context,
                      builder:
                          (context) => TaskAlertDialogWidget(
                            titleTextController: titleTextController,
                            descriptionTextController:
                                descriptionTextController,
                            onPressed: () {
                              if (titleTextController.text.trim().isNotEmpty) {
                                ref
                                    .read(repositoryProvider)
                                    .editTask(
                                      title: titleTextController.text.trim(),
                                      description:
                                          descriptionTextController.text.trim(),
                                      importance: ref.watch(
                                        radioGroupValueProvider,
                                      ),
                                      id: task.id,
                                    );
                              }
                              Navigator.pop(context);
                              titleTextController.clear();
                              descriptionTextController.clear();
                            },
                          ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: const Color.fromARGB(255, 38, 123, 41),
                  ),
                ),
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
