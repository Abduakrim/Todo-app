import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1),
        ),
      ),
    );
  }
}
