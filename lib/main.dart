import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'application.dart';
import 'firebase_options.dart';
import 'locator.dart';


const uuid = Uuid();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setup();
  runApp(const Application());
}
