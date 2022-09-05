import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:times_curso_diego/controllers/theme_controller.dart';
import 'package:times_curso_diego/models/time.dart';
import 'package:times_curso_diego/pages/time_page.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';
import 'package:times_curso_diego/service/auth_service.dart';
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

  void showEscolherTime() {
    Get.back();

    final times = Provider.of<TimesRepository>(context, listen: false).times;
    List<SimpleDialogOption> items = [];

    times.forEach((time) {
      items.add(
        SimpleDialogOption(
          child: Row(
            children: [
              Brasao(image: time.brasao!, width: 30,),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(time.nome!),
              ),
            ],
          ),
          onPressed: () {
            Get.find<AuthService>().definirTime(time);
            Get.back();
          },
        ),
      );
    });

    final SimpleDialog dialog = SimpleDialog(
      title: Text('Escolha sua torcida'),
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 6),
      children: items,
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<TimesRepository>(
          builder: (context, repositorio, child) {
            return repositorio.loading.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      Text('Atualizando...'),
                    ],
                  )
                : const Text('Tabela Brasileirão');
          },
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(
                    () => controller.isDark.value
                        ? const Icon(Icons.brightness_7)
                        : const Icon(Icons.brightness_2),
                  ),
                  title: Obx(() => controller.isDark.value
                      ? const Text('Light')
                      : const Text('Dark')),
                  onTap: () => controller.changeTheme(),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.sports_soccer),
                  title: const Text('Escolher Torcida'),
                  onTap: () =>
                    showEscolherTime(),

                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Sair'),
                  onTap: () {
                    Navigator.pop(context);
                    AuthService.to.logout();
                  },
                ),
              )
            ],
          ),
        ],
      ),
      body: Consumer<TimesRepository>(
        builder: (context, repositorio, child) {
          return RefreshIndicator(
            onRefresh: () => repositorio.updateTabela(),
            child: ListView.separated(
              itemCount: repositorio.times.length,
              itemBuilder: (context, int time) {
                final List<Time> tabela = repositorio.times;
                return ListTile(
                  leading: Brasao(
                    image: tabela[time].brasao.toString(),
                    width: 40,
                  ),
                  title: Text(tabela[time].nome.toString()),
                  subtitle: Text('Titulos: ${tabela[time].titulos!.length}'),
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
            ),
          );
        },
      ),
    );
  }
}
