import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:times_curso_diego/database/db.dart';
import 'package:times_curso_diego/database/db_firestore.dart';
import 'package:times_curso_diego/models/titulo.dart';
import '../models/time.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];
  final loading = ValueNotifier(false);

  UnmodifiableListView<Time> get times => UnmodifiableListView(_times);

  Future<void> addTitulo({Time? time, Titulo? titulo}) async {
    // var db = await DB.get();
    // int id = await db.insert('titulos', {
    //   'campeonato': titulo!.campeonato,
    //   'ano': titulo.ano,
    //   'time_id': time!.id,
    // });
    // titulo.id = id;

    FirebaseFirestore db = await DBFirestore.get();
    var docRef = await db.collection('titulos').add({
      'campeonato': titulo!.campeonato,
      'ano': titulo.ano,
      'time_id': time!.id,
    });
    titulo.id = docRef.id;

    time.titulos!.add(titulo);
    notifyListeners();
  }

  Future<void> editTitulo(
      {Titulo? titulo, String? ano, String? campeonato}) async {
    // var db = await DB.get();
    // await db.update(
    //   'titulos',
    //   {
    //     'campeonato': campeonato,
    //     'ano': ano,
    //   },
    //   where: 'id = ?',
    //   whereArgs: [titulo!.id],
    // );
    FirebaseFirestore db = await DBFirestore.get();
    await db.collection('titulos').doc(titulo!.id).update({
      'campeonato': campeonato,
      'ano': ano,
    });
    titulo.campeonato = campeonato;
    titulo.ano = ano;
    notifyListeners();
  }

  TimesRepository() {
    initRepository();
  }

  showLoading(bool valor) {
    loading.value = valor;
    notifyListeners();
  }

  updateTabela() async {
    showLoading(true);

    //CODIGO DIO
    var http = Dio();
    var response = await http.get(
        'https://api.api-futebol.com.br/v1/campeonatos/10/fases/168',
        options: Options(headers: {
          'Authorization': 'Bearer live_b699617e52705c2fb792e0bbefafee',
        }));

    //CODIGO HTTP
    // var response = await http.get(
    //   Uri.parse('https://api.api-futebol.com.br/v1/campeonatos/10/fases/168'),
    //   headers: {
    //     HttpHeaders.authorizationHeader:
    //         'Bearer live_b699617e52705c2fb792e0bbefafee'
    //   },
    // );

    if (response.statusCode == 200) {
      // final json = jsonDecode(response.body);  //CODIGO HTTP
      final json = response.data;
      final tabela = json['tabela'];
      final db = await DB.get();

      tabela.forEach((linha) async {
        final idAPI = linha['time']['time_id'];
        final pontos = linha['pontos'];

        await db.update(
          'times',
          {'pontos': pontos},
          where: 'idAPI = ?',
          whereArgs: [idAPI],
        );
        Time t = _times.firstWhere((time) => time.idAPI == idAPI);
        t.pontos = pontos;
        notifyListeners();
        showLoading(false);
      });
    } else {
      throw Exception('falha API');
    }
  }

  void initRepository() async {
    var db = await DB.get(); //acessa o dataBase
    List ts = await db.query('times',
        orderBy: 'pontos DESC'); //faz uma QUERY de todos os times

    for (var t in ts) {
      var time = Time(
          id: t['id'],
          nome: t['nome'],
          brasao: t['brasao'],
          pontos: t['pontos'],
          idAPI: t['idAPI'],
          cor: Color(int.parse(t['cor'])),
          titulos: await getTitulos(t['id']));

      _times.add(time);
    }
    updateTabela();
    notifyListeners();
  }

  getTitulos(timeId) async {
    // var db = await DB.get();
    // var results =
    // await db.query('titulos', where: 'time_id = ?', whereArgs: [timeId]);
    // List<Titulo> titulos = [];
    // for (var titulo in results) {
    //   titulos.add(
    //     Titulo(
    //       id: titulo['id'],
    //       campeonato: titulo['campeonato'],
    //       ano: titulo['ano'],
    //     ),
    //   );
    // }
    FirebaseFirestore db = await DBFirestore.get();
    var snapshot = await db
        .collection('titulos')
        .where('time_id', isEqualTo: timeId)
        .get();
    List<Titulo> titulos = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data();
      titulos.add(Titulo(
        id: doc.id,
        campeonato: data['campeonato'],
        ano: data['ano'],
      ));
    });
    return titulos;
  }

  static setupTimes() {
    return [
      Time(
        nome: 'Flamengo',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/flamengo/logo-flamengo-256.png',
        cor: Colors.red[900],
        idAPI: 18,
      ),
      Time(
        nome: 'Internacional',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/internacional/logo-internacional-256.png',
        cor: Colors.red[900],
        idAPI: 44,
      ),
      Time(
        nome: 'Atl??tico-MG',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
        cor: Colors.grey[800],
        idAPI: 30,
      ),
      Time(
        nome: 'S??o Paulo',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/sao-paulo/logo-sao-paulo-256.png',
        cor: Colors.red[900],
        idAPI: 57,
      ),
      Time(
        nome: 'Fluminense',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/fluminense/logo-fluminense-256.png',
        cor: Colors.teal[800],
        idAPI: 26,
      ),
      Time(
        nome: 'Gr??mio',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/gremio/logo-gremio-256.png',
        cor: Colors.blue[900],
        idAPI: 45,
      ),
      Time(
        nome: 'Palmeiras',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/palmeiras/logo-palmeiras-256.png',
        cor: Colors.green[800],
        idAPI: 56,
      ),
      Time(
        nome: 'Santos',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/santos/logo-santos-256.png',
        cor: Colors.grey[800],
        idAPI: 63,
      ),
      Time(
        nome: 'Athletico-PR',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-paranaense/logo-atletico-paranaense-256.png',
        cor: Colors.red[900],
        idAPI: 185,
      ),
      Time(
        nome: 'Corinthians',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/corinthians/logo-corinthians-256.png',
        cor: Colors.grey[800],
        idAPI: 65,
      ),
      Time(
        nome: 'Bragantino',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/red-bull-bragantino/logo-red-bull-bragantino-256.png',
        cor: Colors.grey[800],
        idAPI: 64,
      ),
      Time(
        nome: 'Cear??',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/ceara/logo-ceara-256.png',
        cor: Colors.grey[800],
        idAPI: 105,
      ),
      Time(
        nome: 'Atl??tico-GO',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/atletico-goianiense/logo-atletico-goianiense-256.png',
        cor: Colors.red[900],
        idAPI: 98,
      ),
      Time(
        nome: 'Sport',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/sport-recife/logo-sport-recife-256.png',
        cor: Colors.red[900],
        idAPI: 79,
      ),
      Time(
        nome: 'Bahia',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/bahia/logo-bahia-256.png',
        cor: Colors.blue[900],
        idAPI: 68,
      ),
      Time(
        nome: 'Fortaleza',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/fortaleza/logo-fortaleza-256.png',
        cor: Colors.red[900],
        idAPI: 131,
      ),
      Time(
        nome: 'Vasco',
        pontos: 0,
        brasao:
            'https://logodetimes.com/times/vasco-da-gama/logo-vasco-da-gama-256.png',
        cor: Colors.grey[800],
        idAPI: 23,
      ),
      Time(
        nome: 'Goi??s',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/goias/logo-goias-esporte-clube-256.png',
        cor: Colors.green[900],
        idAPI: 115,
      ),
      Time(
        nome: 'Coritiba',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/coritiba/logo-coritiba-5.png',
        cor: Colors.green[900],
        idAPI: 84,
      ),
      Time(
        nome: 'Botafogo',
        pontos: 0,
        brasao: 'https://logodetimes.com/times/botafogo/logo-botafogo-256.png',
        cor: Colors.grey[800],
        idAPI: 22,
      ),
    ];
  }
}
