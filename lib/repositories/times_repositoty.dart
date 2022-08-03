import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/time.dart';
import '../models/titulo.dart';

class TimesRepository extends ChangeNotifier{
    final List<Time> _times = [];

    UnmodifiableListView<Time>  get times => UnmodifiableListView(_times);

    void addTitulo({ Time? time,  Titulo? titulo}){
      time?.titulos.add(titulo!);
      notifyListeners();
    }

    TimesRepository(){
      _times.addAll([

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
          nome: 'Atlético-MG',
          pontos: 0,
          brasao:
          'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
          cor: Colors.grey[800],
          idAPI: 30,
        ),
        Time(
          nome: 'São Paulo',
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
          nome: 'Grêmio',
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
          nome: 'Ceará',
          pontos: 0,
          brasao: 'https://logodetimes.com/times/ceara/logo-ceara-256.png',
          cor: Colors.grey[800],
          idAPI: 105,
        ),
        Time(
          nome: 'Atlético-GO',
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
          nome: 'Goiás',
          pontos: 0,
          brasao: 'https://logodetimes.com/times/goias/logo-goias-novo-256.png',
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

      ]);
    }
}