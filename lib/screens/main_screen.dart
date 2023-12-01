import 'package:flutter/material.dart';
import 'package:todo_firebase/core/cubits/success_dialog_cubit.dart';
import 'package:todo_firebase/screens/home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/widgets/error_flash_bar.dart';
import 'package:todo_firebase/widgets/success_flush_bar.dart';
import '../core/cubits/error_dialog_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SuccessDialogCubit, bool>(
          listener: (context, state) {
            if (state) {
              SuccessFlushBar("success").show(context);
            }
          },
        ),
        BlocListener<ErrorDialogCubit, bool>(
          listener: (context, state) {
            if (state) {
              ErrorFlushBar("error").show(context);
            }
          },
        ),
      ],
      child: const HomeScreen(),
    );
  }
}
