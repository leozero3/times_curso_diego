import 'package:flutter/material.dart';
import 'package:times_curso_diego/pages/home_controller.dart';
//home_page

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Brasileirão'),
      ),
      body: ListView.separated(
          itemBuilder: (context, int i) {
            final tabela = controller.tabela;
            return ListTile(
              leading: Image.network(tabela[i].brasao!),
              title: Text(tabela[i].nome!),
              trailing: Text(tabela[i].pontos.toString()),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          padding: EdgeInsets.all(16),
          itemCount: controller.tabela.length),
    );
  }
}
