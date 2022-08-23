import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/controllers/autentication_controller.dart';


class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);
  AutenticationController controller = Get.put(AutenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Obx(() => Text(controller.titulo.value)),
        actions: [
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
            ),
            child: Obx(() => Text(controller.appBarButton.value)),
          ),
        ],
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if (value!.isEmpty) {
                    return 'Informe o Email corretamente';
                  }
                  return null;
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: controller.senha,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Senha'),
                //validator: (){}
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('data'),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
