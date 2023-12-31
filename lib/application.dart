import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/success_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/task/task_cubit.dart';
import 'package:todo_firebase/locator.dart';
import 'package:todo_firebase/screens/main_screen.dart';

import 'core/providers/task_provider.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  late ErrorDialogCubit errorDialogCubit;
  late SuccessDialogCubit successDialogCubit;
  late TaskProvider taskProvider;
  late TaskCubit taskCubit;

  @override
  void initState() {
    errorDialogCubit= locator();
    successDialogCubit= locator();
    taskProvider= locator();
    taskCubit= locator();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => errorDialogCubit),
        BlocProvider(create: (context) => successDialogCubit),
        BlocProvider(create: (context) => taskCubit),
        ChangeNotifierProvider(create: (local) => taskProvider),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
