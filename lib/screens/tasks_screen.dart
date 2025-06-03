import 'dart:ui';

import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:drift_todo/widgets/shadow_button.dart';
import 'package:drift_todo/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TasksScreen extends HookConsumerWidget {
  const TasksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(getAllTasksProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Todo App')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: RefreshIndicator.adaptive(
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
                          (context, index) => TaskWidget(task: data[index]),
                      itemCount: 10,
                      separatorBuilder: (context, index) => Gap(10),
                    ),
                error: (error, stackTrace) => Center(child: Text('$error')),
                loading: () => CircularProgressIndicator.adaptive(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AddTaskWidget(),
    );
  }
}

class AddTaskWidget extends HookConsumerWidget {
  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTextController = useTextEditingController();
    final descriptionTextController = useTextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ShadowButton(
        buttonColor: const Color.fromARGB(255, 134, 197, 137),
        backButtonColor: Colors.green,
        child: Text(
          'Add',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  children: [
                    TextField(controller: titleTextController),
                    TextField(controller: descriptionTextController),
                  ],
                ),
                actions: [
                  ShadowButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ShadowButton(
                    child: Text('Add'),
                    onPressed:
                        () => ref
                            .read(repositoryProvider)
                            .addTask(
                              title: titleTextController.text,
                              description: descriptionTextController.text,
                            ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
