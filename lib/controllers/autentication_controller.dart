import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutenticationController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var titulo = 'Bem vindo!'.obs;
  var botaoPrincipal = 'Entrar'.obs;
  var appBarButton = 'Cadastre-se'.obs;
  final isLogin = true.obs;

  @override
  void onInit() {
    super.onInit();
    ever(isLogin, (visible) {
      titulo.value = visible != null ? 'Bem vindo!' : 'Crie sua Conta';
      botaoPrincipal.value = visible != null ? 'Entrar' : 'Registre-se';
      appBarButton.value = visible != null ? 'Cadastre-se' : 'Login';
      formKey.currentState?.reset();
    });
  }

  login() {
    print('O Email é ${email.text} e a senha é ${senha.text}');
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
