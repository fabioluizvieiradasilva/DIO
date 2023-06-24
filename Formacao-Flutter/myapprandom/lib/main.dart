import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapprandom/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'model/perfil_model.dart';
import 'model/tarefa_model.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE tarefas(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao TEXT,
    concluido INTEGER
  );    
  '''
};

//Criando banco de dados SQLite
Future iniciarBancoDados() async {
  var db = await openDatabase(
    path.join(await getDatabasesPath(), 'database.db'),
    version: scripts.length,
    onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    },
  );
  return db;
}

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

  await iniciarBancoDados();

  runApp(const MyApp());
}
