import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/firebase_options.dart';
import 'package:times_curso_diego/service/auth_service.dart';
import 'controllers/theme_controller.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.useFirestoreEmulator('10.0.2.2', 8080,sslEnabled: false);

  // FirebaseFirestore.instance.settings =
  //     Settings(host: 'localhost:8080', sslEnabled: false);

  //GetX bindings
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
}
