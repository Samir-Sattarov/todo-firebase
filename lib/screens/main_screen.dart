import 'package:flutter/material.dart';
import 'package:todo_firebase/screens/home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/widgets/error_flash_bar.dart';
import '../core/cubits/error_dialog_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // BlocListener<, SubjectState>(
        //   listener: (context, state) {
          // },
        // ),
        BlocListener<ErrorDialogCubit, bool>(
          listener: (context, state) {

            print("State $state");
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
