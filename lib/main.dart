import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_curso_diego/pages/home_page.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimesRepository(),
      child: const MeuAplicativo(),
    ),
  );
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brasileirão',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}
