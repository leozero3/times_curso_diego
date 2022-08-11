import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:times_curso_diego/controllers/theme_controller.dart';
import 'package:times_curso_diego/models/time.dart';
import 'package:times_curso_diego/pages/time_page.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';
import 'package:times_curso_diego/widgets/brasao.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeController.to;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = HomeController();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasileirão'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(
                    () => controller.isDark.value
                        ? Icon(Icons.brightness_7)
                        : Icon(Icons.brightness_2),
                  ),
                  title: Obx(() => controller.isDark.value ? Text('Light') : Text('Dark')),
                  onTap: ()=> controller.changeTheme(),
                ),
              )
            ],
          ),
        ],
      ),
      body: Consumer<TimesRepository>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.times.length,
            itemBuilder: (context, int time) {
              final List<Time> tabela = repositorio.times;
              return ListTile(
                leading: Brasao(
                  image: tabela[time].brasao.toString(),
                  width: 40,
                ),
                title: Text(tabela[time].nome.toString()),
                subtitle: Text('Titulos: ${tabela[time].titulos.length}'),
                trailing: Text(tabela[time].pontos.toString()),
                onTap: () {
                  Get.to(
                    () => TimePage(
                      key: Key(tabela[time].nome.toString()),
                      time: tabela[time],
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TimePage(
                  //       key: Key(tabela[time].nome.toString()),
                  //       time: tabela[time],
                  //     ),
                  //   ),
                  // );
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            padding: const EdgeInsets.all(16),
          );
        },
      ),
    );
  }
}
