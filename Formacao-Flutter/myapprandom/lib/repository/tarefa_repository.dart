import 'package:myapprandom/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  void adicionar(Tarefa tarefa) {
    _tarefas.add(tarefa);
  }

  void alterar(String id, bool concluido) {
    _tarefas.where((element) => element.id == id).first.concluido = concluido;
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
  }
}
