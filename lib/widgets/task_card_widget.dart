import 'package:flutter/material.dart';

import '../core/entity/task_entity.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEntity task;
  final Function(TaskEntity) onTap;
  final Function(TaskEntity) onDoubleTap;
  const TaskCardWidget({super.key, required this.task, required this.onTap, required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => onTap.call(task),
      onDoubleTap:() => onDoubleTap.call(task),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title),
            const SizedBox(height: 10),
            Text(task.description),
          ],
        ),
      ),
    );
  }
}
