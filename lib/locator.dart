import 'package:get_it/get_it.dart';
import 'package:todo_firebase/core/api/firestore_api.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/success_dialog_cubit.dart';
import 'package:todo_firebase/core/providers/task_provider.dart';

final locator = GetIt.I;

void setup() {
  locator.registerFactory(() => SuccessDialogCubit());
  locator.registerFactory(() => ErrorDialogCubit());

  locator.registerFactory(() => TaskProvider(
         locator(),
         locator(),
         locator(),
      ));


  locator.registerLazySingleton(() => FirestoreApi());
}
