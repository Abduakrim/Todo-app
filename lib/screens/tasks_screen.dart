import 'dart:ui';

import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:drift_todo/widgets/add_task_widget.dart';
import 'package:drift_todo/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(getAllTasksProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.2),
        title: Text('Todo App'),

        actions: [
          if (ref.watch(selectedTasksProvider).isNotEmpty)
            IconButton(
              onPressed: () {
                final choosedTasks = ref.watch(selectedTasksProvider);
                for (var task in choosedTasks) {
                  ref.read(repositoryProvider).deleteTask(id: task);
                }
                ref.invalidate(selectedTasksProvider);
              },
              icon: Icon(Icons.delete_forever),
            ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: RefreshIndicator.adaptive(
          color: Colors.lightGreen,
          backgroundColor: Colors.green,
          onRefresh: () async => ref.invalidate(getAllTasksProvider),
          child: Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 156, 216, 158),
                height: 700,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 600, sigmaY: 600),
                child: SizedBox(height: MediaQuery.of(context).size.height),
              ),
              tasks.when(
                data:
                    (data) => ListView.separated(
                      itemBuilder:
                          (context, index) =>
                              TaskWidget(task: data.reversed.toList()[index]),
                      itemCount: data.length,
                      separatorBuilder: (context, index) => Gap(10),
                    ),
                error: (error, stackTrace) => Center(child: Text('$error')),
                loading: () => CircularProgressIndicator.adaptive(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          if (width > 600) {
            return AddTaskWidget();
          } else {
            return SizedBox();
          }
        },
      ),

      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          if (width > 600) {
            return SizedBox();
          } else {
            return AddTaskWidget();
          }
        },
      ),
    );
  }
}
