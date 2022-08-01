import 'package:flutter/material.dart';
import 'package:times_curso_diego/models/time.dart';
import 'package:times_curso_diego/pages/home_controller.dart';
import 'package:times_curso_diego/pages/time_page.dart';
//home_page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasileirão'),
      ),
      body: ListView.separated(
          itemBuilder: (context, int time) {
            final List<Time> tabela = controller.tabela;

            return ListTile(
              leading: Image.network(tabela[time].brasao.toString()),
              title: Text(tabela[time].nome.toString()),
              trailing: Text(tabela[time].pontos.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimePage(
                      key: Key(tabela[time].nome.toString()),
                      time: tabela[time],
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          padding: const EdgeInsets.all(16),
          itemCount: controller.tabela.length),
    );
  }
}
