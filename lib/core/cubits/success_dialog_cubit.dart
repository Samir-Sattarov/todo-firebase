
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessDialogCubit extends Cubit<bool> {
  SuccessDialogCubit() : super(false);


  enable() {
    emit(true);

    Timer(const Duration(milliseconds: 300), () => _disable());
  }

  _disable() => emit(false);
}
