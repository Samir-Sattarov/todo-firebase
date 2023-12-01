// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  FirebaseFirestore instance = FirebaseFirestore.instance;


  Future<bool> post({
    required String collection,
    required Map<String, dynamic> params,
  }) async {
    print("send data");

    instance.collection(collection).doc(params['id']).set(params)
      ..then((value) => print("Data saved"))
      ..catchError((error) async {
        print("Error $error");
        return Future.value(false);
      });

    return true;
  }

 Future<void> delete({required String id, required String collection}) async {

   await instance
        .collection(collection)
        .doc(id)
        .delete()
     .then((value) => print("Data saved"))
     .catchError((error) async {
       print("Error $error");
       return Future.value(false);
     });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> get({
    required String collection,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await instance.collection(collection).get();

    print(data);
    return data;
  }
}
