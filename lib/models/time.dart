import 'package:flutter/material.dart';
import 'package:times_curso_diego/models/titulo.dart';

class Time {
  int? id;
  String? nome;
  String? brasao;
  int? pontos;
  Color? cor;
  int? idAPI;
  List<Titulo>? titulos = [];

  Time({
    this.id,
    this.nome,
    this.brasao,
    this.pontos,
    this.cor,
    this.titulos,
    this.idAPI,
  });
}
