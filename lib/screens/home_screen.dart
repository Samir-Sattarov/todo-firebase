import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/providers/task_provider.dart';
import 'package:todo_firebase/screens/create_task_screen.dart';
import 'package:todo_firebase/widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase"),
        actions: [
          IconButton(
            onPressed: () {
              fetchData();
            },
            icon: const Icon(
              Icons.cloud,
            ),
          )
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (_, data, child) {
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: data.listTask.length,
            itemBuilder: (_, index) {
              final element = data.listTask[index];
              return TaskCardWidget(task: element);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
