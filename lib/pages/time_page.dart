import 'package:flutter/material.dart';
import 'package:times_curso_diego/pages/add_titulo_page.dart';
import '../models/time.dart';
import '../models/titulo.dart';

class TimePage extends StatefulWidget {
  Time? time;

  TimePage({Key? key, this.time}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  tituloPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTituloPage(time: widget.time, onSave: addTitulo),
      ),
    );
  }

  addTitulo(Titulo titulo) {
    setState(() {
      widget.time!.titulos.add(titulo);
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Salvo com sucesso!')),
    );
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
                  child: Image.network(
                    widget.time!.brasao!.replaceAll("40x40", "100x100"),
                  ),
                ),
                Text(
                  'Pontos: ${widget.time!.pontos}',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
            titulos(),
          ],
        ),
      ),
    );
  }

  titulos() {
    final quantidade = widget.time!.titulos.length;
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
                title: Text(widget.time!.titulos[index].campeonato.toString()),
                trailing: Text(widget.time!.titulos[index].ano.toString()),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: quantidade);
  }
}
