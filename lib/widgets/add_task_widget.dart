import 'package:drift_todo/providers/is_scale_button_provider.dart';
import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:drift_todo/widgets/task_alert_dialog_widget.dart';
import 'package:drift_todo/widgets/shadow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTaskWidget extends HookConsumerWidget {
  const AddTaskWidget({super.key, this.padding});
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTextController = useTextEditingController();
    final descriptionTextController = useTextEditingController();
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: MyButton(
        isScaleButton: ref.watch(isScaleButtonProvider),
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
              return TaskAlertDialogWidget(
                importance: 1,
                titleTextController: titleTextController,
                descriptionTextController: descriptionTextController,
                onPressed: () {
                  if (titleTextController.text.trim().isNotEmpty) {
                    ref
                        .read(repositoryProvider)
                        .addTask(
                          title: titleTextController.text.trim(),
                          description: descriptionTextController.text.trim(),
                          importance: ref.watch(radioGroupValueProvider),
                        );
                  }
                  Navigator.pop(context);
                  titleTextController.clear();
                  descriptionTextController.clear();
                },
              );
            },
          );
        },
      ),
    );
  }
}
