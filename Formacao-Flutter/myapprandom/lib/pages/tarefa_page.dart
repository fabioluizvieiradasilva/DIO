import 'package:flutter/material.dart';
import 'package:myapprandom/model/tarefa.dart';
import 'package:myapprandom/repository/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var descricaoController = TextEditingController();
  var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var naoConcluidos = false;

  void getTarefas() {
    _tarefas = naoConcluidos
        ? tarefaRepository.listarNaoConcluido()
        : tarefaRepository.listar();
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
                      tarefaRepository
                          .adicionar(Tarefa(descricaoController.text, false));
                      Navigator.pop(context);
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
                      tarefaRepository.excluir(_tarefas[index].id);
                      getTarefas();
                    },
                    child: ListTile(
                      title: Text(_tarefas[index].descricao),
                      trailing: Switch(
                        value: _tarefas[index].concluido,
                        onChanged: (bool value) {
                          tarefaRepository.alterar(_tarefas[index].id, value);
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
