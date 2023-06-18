import 'package:flutter/material.dart';
import 'package:myapprandom/model/tarefa_model.dart';
import 'package:myapprandom/repository/tarefa_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaRepository tarefaRepository;

  var descricaoController = TextEditingController();
  //var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var naoConcluidos = false;

  var tarefa = Tarefa();

  void getTarefas() async {
/*     _tarefas = naoConcluidos
        ? tarefaRepository.listarNaoConcluido()
        : tarefaRepository.listar(); */

    tarefaRepository = await TarefaRepository.carregar();
    _tarefas = tarefaRepository.obterDados(naoConcluidos);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(
                  controller: descricaoController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      tarefaRepository.salvar(
                          Tarefa.criar(descricaoController.text, false));
                      Navigator.pop(context);
                      getTarefas();
                      setState(() {});
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Apenas não concluído",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: naoConcluidos,
                    onChanged: (bool value) {
                      naoConcluidos = value;
                      getTarefas();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  return Dismissible(
                    key: Key(_tarefas[index].id),
                    onDismissed: (direction) {
                      tarefaRepository.excluir(_tarefas[index]);
                      getTarefas();
                    },
                    child: ListTile(
                      title: Text(_tarefas[index].descricao),
                      trailing: Switch(
                        value: _tarefas[index].concluido,
                        onChanged: (bool value) {
                          _tarefas[index].concluido = value;
                          tarefaRepository.alterar(_tarefas[index]);
                          getTarefas();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
