import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/database/db_firestore.dart';
import 'package:times_curso_diego/models/time.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<User> _firebaseUser = Rxn<User>();

  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      if (user != null) {
        userIsAuthenticated.value = true;
      } else {
        userIsAuthenticated.value = false;
      }
    });
  }

  User? get user => _firebaseUser.value;

  static AuthService get to => Get.find<AuthService>();

  definirTime(Time time) async {
    final userId = _firebaseUser.value!.uid;
    try{
      FirebaseFirestore db = await DBFirestore.get();
      await db.collection('usuarios').doc(userId).set({
        'time_id': time.id,
        'time_nome': time.nome,
      });
    }catch (e){
      showSnack('Erro ao definir time', e.toString());
    }
  }

  showSnack(String titulo, String erro) {
    Get.snackbar(
      titulo,
      erro,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  creteUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnack('Erro ao registrar', e.message.toString());
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnack('Erro no Login', e.message.toString());
    }
  }

  logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnack('Erro ao sair', e.message.toString());
    }
  }
}
