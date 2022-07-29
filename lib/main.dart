import 'package:flutter/material.dart';
import 'package:times_curso_diego/pages/home_page.dart';

void main() => runApp(const MeuAplicativo());

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Brasileirão',
      home: HomePage(),
    );
  }
}
