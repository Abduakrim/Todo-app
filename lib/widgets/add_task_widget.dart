import 'dart:ui';
import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:drift_todo/widgets/shadow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                backgroundColor: const Color.fromARGB(255, 146, 199, 148),
                content: SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      TextField(
                        controller: titleTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                      Gap(20),
                      TextField(
                        controller: descriptionTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ShadowButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ShadowButton(
                    child: Text('Add'),
                    onPressed: () {
                      if (titleTextController.text.trim().isNotEmpty) {
                        ref
                            .read(repositoryProvider)
                            .addTask(
                              title: titleTextController.text.trim(),
                              description:
                                  descriptionTextController.text.trim(),
                            );
                      }
                      Navigator.pop(context);
                      titleTextController.clear();
                      descriptionTextController.clear();
                    },
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
