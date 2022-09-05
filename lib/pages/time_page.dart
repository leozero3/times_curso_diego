import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:times_curso_diego/database/db_firestore.dart';
import 'package:times_curso_diego/pages/add_titulo_page.dart';
import 'package:times_curso_diego/pages/edit_titulo_page.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';
import 'package:times_curso_diego/widgets/brasao.dart';
import '../models/time.dart';

class TimePage extends StatefulWidget {
  Time? time;

  TimePage({Key? key, this.time}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  FirebaseFirestore? db;
  Stream<DocumentSnapshot>? torcedoresSnapshot;

  @override
  void initState() {
    super.initState();
    db = DBFirestore.get();
    torcedoresSnapshot = db?.doc('times/${widget.time!.id}').snapshots();
  }

  tituloPage() {
    Get.to(
      () => AddTituloPage(time: widget.time),
    );

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => AddTituloPage(time: widget.time),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.time!.cor,
          title: Text(widget.time!.nome.toString()),
          actions: [
            IconButton(
                onPressed: () {
                  tituloPage();
                },
                icon: const Icon(Icons.add))
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Estatatisticas',
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: 'Títulos',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Brasao(
                    image: widget.time!.brasao.toString(),
                    width: 250,
                  ),
                ),
                Text(
                  'Pontos: ${widget.time!.pontos}',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: torcedoresSnapshot,
                  builder: (context, snapshot) {
                    return Text(

                      'Torcedores ${snapshot.data != null?['torcedores'] == null : '0'}',
                      style: TextStyle(fontSize: 22),
                    );
                  },
                ),
              ],
            ),
            titulos(),
          ],
        ),
      ),
    );
  }

  titulos() {
    final time = Provider.of<TimesRepository>(context)
        .times
        .firstWhere((t) => t.nome == widget.time!.nome);
    final quantidade = time.titulos!.length;

    return quantidade == 0
        ? Container(
            child: const Center(
              child: Text('Nenhum Título Ainda!'),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.emoji_events),
                title: Text(time.titulos![index].campeonato.toString()),
                trailing: Text(time.titulos![index].ano.toString()),
                onTap: () {
                  Get.to(
                    EditTituloPage(titulo: time.titulos![index]),
                    fullscreenDialog: true,
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: quantidade);
  }
}
