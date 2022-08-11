import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_curso_diego/models/titulo.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';

class EditTituloPage extends StatefulWidget {
  Titulo? titulo;

  EditTituloPage({Key? key, this.titulo}) : super(key: key);

  @override
  State<EditTituloPage> createState() => _EditTituloPageState();
}

class _EditTituloPageState extends State<EditTituloPage> {
  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  editar() {
    Provider.of<TimesRepository>(context, listen: false).editTitulo(
      titulo: Titulo(ano: _ano.text, campeonato: _campeonato.text),
      campeonato: _campeonato.text,
      ano: _ano.text,
    );
  }

  @override
  void initState() {
    super.initState();
    _ano.text = widget.titulo!.ano!;
    _campeonato.text = widget.titulo!.campeonato!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Título'),
        backgroundColor: Colors.grey[800],
        actions: [IconButton(onPressed: editar, icon: const Icon(Icons.check))],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o ano do título';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: TextFormField(
                controller: _campeonato,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe qual é o campeonato';
                  }
                  return null;
                },
              ),
            ),
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     margin: const EdgeInsets.all(24),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         if (_formKey.currentState!.validate()) {
            //           editar();
            //         }
            //       },
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: const [
            //           Icon(Icons.check),
            //           Padding(
            //             padding: EdgeInsets.all(16),
            //             child: Text(
            //               'Salvar',
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
