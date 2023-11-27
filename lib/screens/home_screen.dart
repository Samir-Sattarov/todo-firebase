import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
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
      body: Center(
        child: Consumer<TaskProvider>(
          builder: (_, data, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...List.generate(
                  data.listTask.length,
                  (index) {
                    final element = data.listTask[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(element.title),
                          const SizedBox(height: 10),
                          Text(element.description),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
