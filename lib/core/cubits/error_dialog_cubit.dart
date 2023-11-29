

import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorDialogCubit extends Cubit<bool> {
  ErrorDialogCubit() : super(false);


  enable() => emit(true);

  disable() => emit(false);

}
