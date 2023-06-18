import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapprandom/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'model/perfil_model.dart';
import 'model/tarefa_model.dart';

void main() async {
  //Carrega todos os bindings
  WidgetsFlutterBinding.ensureInitialized();

  //Obtém o diretório de documentos da aplicação
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  //Cria o banco de dados Hive no diretório documentos da aplicação
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(PerfilModelAdapter());
  Hive.registerAdapter(TarefaAdapter());

  runApp(const MyApp());
}
