import 'package:drift_todo/providers/is_scale_button_provider.dart';
import 'package:drift_todo/widgets/shadow_button.dart';
import 'package:drift_todo/widgets/task_radio_widget.dart';
import 'package:drift_todo/widgets/task_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskAlertDialogWidget extends HookConsumerWidget {
  final int importance;
  const TaskAlertDialogWidget({
    super.key,
    required this.titleTextController,
    required this.descriptionTextController,
    required this.onPressed,
    required this.importance,
  });

  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 146, 199, 148),
      content: SizedBox(
        height: 400,
        child: Column(
          children: [
            TaskTextField(controller: titleTextController),
            Gap(20),
            TaskTextField(controller: descriptionTextController),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskRadioWidget(
                  value: 0,
                  title: 'LOW',
                  color: Colors.blue,
                  initialGroup: importance,
                ),
                TaskRadioWidget(
                  value: 1,
                  title: 'MEDIUM',
                  color: Colors.green,
                  initialGroup: importance,
                ),
                TaskRadioWidget(
                  value: 3,
                  title: 'HIGH',
                  color: Colors.red,
                  initialGroup: importance,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        MyButton(
          isScaleButton: ref.watch(isScaleButtonProvider),
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        MyButton(
          isScaleButton: ref.watch(isScaleButtonProvider),
          onPressed: onPressed,
          child: Text('Add'),
        ),
      ],
    );
  }
}
