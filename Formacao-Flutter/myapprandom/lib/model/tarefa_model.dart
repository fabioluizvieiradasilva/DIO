import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'tarefa_model.g.dart';

@HiveType(typeId: 1)
class Tarefa extends HiveObject {
  @HiveField(0)
  final String _id = UniqueKey().toString();

  @HiveField(1)
  String _descricao = "";

  @HiveField(2)
  bool _concluido = false;

  Tarefa();
  Tarefa.criar(this._descricao, this._concluido);

  String get id => _id;
  String get descricao => _descricao;
  bool get concluido => _concluido;

  set descricao(String descricao) {
    _descricao = descricao;
  }

  set concluido(bool concluido) {
    _concluido = concluido;
  }
}
