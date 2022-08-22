import 'package:flutter/material.dart';
import 'package:times_curso_diego/pages/authentication_page.dart';
import 'package:times_curso_diego/pages/home_page.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  final bool userIsAutenticated = false;

  @override
  Widget build(BuildContext context) {
    return userIsAutenticated ? HomePage() : AuthenticationPage();
  }
}
