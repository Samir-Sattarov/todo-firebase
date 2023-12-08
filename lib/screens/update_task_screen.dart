import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/entity/task_entity.dart';

import '../core/cubits/task/task_cubit.dart';
import '../core/providers/task_provider.dart';
import '../main.dart';

class UpdateTaskScreen extends StatefulWidget {

  final TaskEntity task;
  const UpdateTaskScreen({super.key, required this.task});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    controllerTitle.text = widget.task.title;
    controllerDescription.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controllerTitle,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controllerDescription,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  final task = TaskEntity(
                    title: controllerTitle.text,
                    description: controllerDescription.text,
                    id: widget.task.id,
                  );

                  BlocProvider.of<TaskCubit>(context )
                      .updateTask(task);

                  Navigator.pop(context);
                },
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
