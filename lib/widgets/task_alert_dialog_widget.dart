import 'package:drift_todo/widgets/shadow_button.dart';
import 'package:drift_todo/widgets/task_radio_widget.dart';
import 'package:drift_todo/widgets/task_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskAlertDialogWidget extends HookConsumerWidget {
  const TaskAlertDialogWidget({
    super.key,
    required this.titleTextController,
    required this.descriptionTextController,
    required this.onPressed,
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
                TaskRadioWidget(value: 0, title: 'LOW', color: Colors.blue),
                TaskRadioWidget(value: 1, title: 'MEDIUM', color: Colors.green),
                TaskRadioWidget(value: 3, title: 'HIGH', color: Colors.red),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ShadowButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ShadowButton(onPressed: onPressed, child: Text('Add')),
      ],
    );
  }
}
