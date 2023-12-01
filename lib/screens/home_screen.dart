import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
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


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
   return  const _ContentWidget();
  }
}


class _ContentWidget extends StatefulWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
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
              return TaskCardWidget(task: element, onTap: (entity) {
                Provider.of<TaskProvider>(context, listen: false).deleteTask(entity);
              },);
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
