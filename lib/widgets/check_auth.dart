import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:times_curso_diego/pages/authentication_page.dart';
import 'package:times_curso_diego/pages/home_page.dart';
import 'package:times_curso_diego/service/auth_service.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AuthService.to.userIsAuthenticated.value
          ? HomePage()
          : AuthenticationPage(),
    );
  }
}
