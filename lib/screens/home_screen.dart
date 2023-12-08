import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/task/task_cubit.dart';
import 'package:todo_firebase/core/providers/task_provider.dart';
import 'package:todo_firebase/screens/create_task_screen.dart';
import 'package:todo_firebase/screens/update_task_screen.dart';
import 'package:todo_firebase/widgets/error_flash_bar.dart';
import 'package:todo_firebase/widgets/task_card_widget.dart';

import '../core/entity/task_entity.dart';
import '../locator.dart';

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
    return const _ContentWidget();
  }
}

class _ContentWidget extends StatefulWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  List<TaskEntity> listTasks = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  refresh() => BlocProvider.of<TaskCubit>(context).load();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase"),
        actions: [
          IconButton(
            onPressed: () => refresh(),
            icon: const Icon(
              Icons.cloud,
            ),
          )
        ],
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ErrorFlushBar(state.message).show(context);
          }
        },
        builder: (context, state) {
          if (state is TaskLoaded) {
            listTasks = state.tasks;
          } else if (state is TaskSaved) {
            final index = listTasks
                .indexWhere((element) => element.id == state.taskEntity.id);

            if (index == -1) {
              listTasks.add(state.taskEntity);
            } else {
              listTasks[index] = state.taskEntity;
            }
          } else if (state is TaskDeleted) {
            listTasks.removeWhere((element) => element.id == state.id);
          }

          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (listTasks.isEmpty) {
            return const Center(
                child: Text(
              "Empty...",
              style: TextStyle(color: Colors.black),
            ));
          }

          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: listTasks.length,
            itemBuilder: (_, index) {
              final element = listTasks[index];
              return TaskCardWidget(
                task: element,
                onDoubleTap: (entity) {
                  BlocProvider.of<TaskCubit>(context, listen: false)
                      .deleteTask(entity.id);
                },
                onTap: (entity) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateTaskScreen(task: entity),
                    ),
                  );
                },
              );
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
