import 'package:flutter/material.dart';
import 'package:times_curso_diego/models/titulo.dart';

class Time {
  String? nome;
  String? brasao;
  int? pontos;
  Color? cor;
  List<Titulo> titulos = [];

  Time({
    this.nome,
    this.brasao,
    this.pontos,
    this.cor,
    required int idAPI,
  });
}
