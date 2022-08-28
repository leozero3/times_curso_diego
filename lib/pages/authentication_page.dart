import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/controllers/autentication_controller.dart';

class AuthenticationPage extends StatelessWidget {
  AutenticationController controller = Get.put(AutenticationController());

  AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Obx(() => Text(controller.titulo.value)),
        actions: [
          TextButton(
            onPressed: () {
              print('10');
              controller.toogleRegistrar();
              print('20');
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
            ),
            child: Obx(() => Text(controller.appBarButton.value)),
          ),
        ],
      ),
      body: Obx(() => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator())
            : Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextFormField(
                            controller: controller.email,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o Email corretamente';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextFormField(
                            controller: controller.senha,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe sua Senha';
                              } else if (value.length < 6) {
                                return 'Sua senha deve conter no minimo 6 caracteres';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.isLogin.value) {
                                controller.login();
                              } else {
                                controller.registrar();
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Obx(() => Text(
                                      controller.botaoPrincipal.value,
                                      style: const TextStyle(fontSize: 20),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
