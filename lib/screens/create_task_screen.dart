import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/entity/task_entity.dart';

import '../core/providers/task_provider.dart';
import '../main.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create task"),
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
                    id: uuid.v4(),
                  );

                  Provider.of<TaskProvider>(context, listen: false)
                      .createTask(task);

                  Navigator.pop(context);
                },
                child: const Text("create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
