import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutenticationController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var titulo = 'Bem vindo!'.obs;
  var botaoPrincipal = 'Entrar'.obs;
  var appBarButton = 'Cadastre-se'.obs;
  var isLogin = true.obs;

  @override
  onInit() {
    super.onInit();
    ever(isLogin, (visible) {

      titulo.value = visible == true ? 'Bem vindo!' : 'Crie sua Conta';
      botaoPrincipal.value = visible == true ? 'Entrar' : 'Registre-se';
      appBarButton.value = visible == true ? 'Cadastre-se' : 'Login';
      formKey.currentState?.reset();
    });
  }

  login() {
    print('O email é ${email.text} e senha ${senha.text}');
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
