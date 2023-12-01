import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/success_dialog_cubit.dart';
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

  @override
  void initState() {
    errorDialogCubit= ErrorDialogCubit();
    successDialogCubit= SuccessDialogCubit();
    taskProvider= TaskProvider(successDialogCubit: successDialogCubit, errorDialogCubit: errorDialogCubit);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => errorDialogCubit),
        BlocProvider(create: (context) => successDialogCubit),
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
