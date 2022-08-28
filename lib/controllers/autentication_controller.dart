import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/service/auth_service.dart';

class AutenticationController extends GetxController {
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var titulo = 'Bem vindo!'.obs;
  var botaoPrincipal = 'Entrar'.obs;
  var appBarButton = 'Cadastre-se'.obs;
  var isLogin = true.obs;
  var isLoading = false.obs;

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

  login() async {
    isLoading.value = true;
    await AuthService.to.login(email.text, senha.text);
    isLoading.value = false;
  }

  registrar() async {
    isLoading.value = true;
    await AuthService.to.creteUser(email.text, senha.text);
    isLoading.value = false;
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
