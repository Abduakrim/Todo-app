import 'package:drift_todo/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TaskRadioWidget extends HookConsumerWidget {
  final int value;
  final String title;
  final Color color;
  final int initialGroup;
  const TaskRadioWidget({
    super.key,
    required this.value,
    required this.title,
    required this.color,
    this.initialGroup = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(radioGroupValueProvider.notifier)
            .update((state) => initialGroup);
      });
      return null;
    }, []);
    return Column(
      children: [
        Radio(
          activeColor: color,
          value: value,
          groupValue: ref.watch(radioGroupValueProvider),
          onChanged: (value) {
            ref
                .read(radioGroupValueProvider.notifier)
                .update((state) => value!);
          },
        ),
        Gap(10),
        Text(title, style: TextStyle(fontSize: 20, color: color)),
      ],
    );
  }
}
