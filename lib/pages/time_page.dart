import 'package:flutter/material.dart';
import '../models/time.dart';

class TimePage extends StatefulWidget {
  Time? time;

  TimePage({Key? key, this.time}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      //initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.time!.cor,
          title: Text(widget.time!.nome.toString()),
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
            child: Center(
              child: Text('Nenhum Título Ainda!'),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text(widget.time!.titulos[index].campeonato.toString()),
                trailing: Text(widget.time!.titulos[index].ano.toString()),

              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: quantidade);
  }
}
