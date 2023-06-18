import 'package:hive/hive.dart';
import 'package:myapprandom/model/tarefa_model.dart';

class TarefaRepository {
  static late Box _box;

  TarefaRepository._criar();

  static Future<TarefaRepository> carregar() async {
    if (Hive.isBoxOpen('tarefaModel')) {
      _box = Hive.box('tarefaModel');
    } else {
      _box = await Hive.openBox('tarefaModel');
    }

    return TarefaRepository._criar();
  }

  void salvar(Tarefa tarefa) {
    _box.add(tarefa);
  }

  List<Tarefa> obterDados(bool naoConcluido) {
    return naoConcluido
        ? _box.values
            .cast<Tarefa>()
            .where((element) => !element.concluido)
            .toList()
        : _box.values.cast<Tarefa>().toList();
  }

  void alterar(Tarefa tarefa) {
    tarefa.save();
  }

  void excluir(Tarefa tarefa) {
    tarefa.delete();
  }

  /* final List<Tarefa> _tarefas = [];

  void adicionar(Tarefa tarefa) {
    _tarefas.add(tarefa);
  }



  List<Tarefa> listar() {
    return _tarefas;
  }

  List<Tarefa> listarNaoConcluido() {
    return _tarefas.where((element) => element.concluido == false).toList();
  }

  void excluir(String id) {
    var tarefa = _tarefas.where((element) => element.id == id).first;
    _tarefas.remove(tarefa);
  } */
}
