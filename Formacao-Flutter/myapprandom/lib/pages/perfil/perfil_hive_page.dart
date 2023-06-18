import 'package:flutter/material.dart';
import 'package:myapprandom/model/perfil_model.dart';
import 'package:myapprandom/repository/linguagens_repository.dart';
import 'package:myapprandom/repository/nivel_repository.dart';
import 'package:myapprandom/repository/perfil_repository.dart';

import '../../shared/widgets/text_label.dart';

class PerfilHivePage extends StatefulWidget {
  const PerfilHivePage({super.key});

  @override
  State<PerfilHivePage> createState() => _PerfilHivePageState();
}

class _PerfilHivePageState extends State<PerfilHivePage> {
  late PerfilRepository perfilRepository;
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  //DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  //var nivelSelecionado = "";
  var niveis = [];

  var linguagensRepository = LinguagensRepository();
  //List<String> linguagemSelecionada = [];
  var linguagens = [];

  //double salarioEscolhido = 0;
  //int tempoExperiencia = 0;
  bool salvando = false;

  final String CHAVE_PERFIL_NOME_USUARIO = 'CHAVE_PERFIL_NOME_USUARIO';
  final String CHAVE_PERFIL_DATA_NASCIMENTO = 'CHAVE_PERFIL_DATA_NASCIMENTO';
  final String CHAVE_PERFIL_TEMPO_EXPERIENCIA =
      'CHAVE_PERFIL_TEMPO_EXPERIENCIA';
  final String CHAVE_PERFIL_NIVEL_EXPERIENCIA =
      'CHAVE_PERFIL_NIVEL_EXPERIENCIA';
  final String CHAVE_PERFIL_lINGUAGENS_PROGRAMACAO =
      'CHAVE_PERFIL_lINGUAGENS_PROGRAMACAO';
  final CHAVE_PERFIL_SALARIO = 'CHAVE_PERFIL_SALARIO';

  var perfilModel = PerfilModel.vazio();

  List<DropdownMenuItem> retornaItens(int quantidadeMax) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= quantidadeMax; i++) {
      itens.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return itens;
  }

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagem();
    carregarDados();

    super.initState();
  }

  void carregarDados() async {
    perfilRepository = await PerfilRepository.carregar();
    perfilModel = perfilRepository.obterDados();
    //storage = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = perfilModel.nome ?? '';
      dataNascimentoController.text = perfilModel.dataNascimento.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: salvando
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    const TextLabel(
                      texto: "Nome",
                    ),
                    TextField(
                      controller: nomeController,
                    ),
                    const TextLabel(
                      texto: "Data de Nascimento",
                    ),
                    TextField(
                      controller: dataNascimentoController,
                      readOnly: true,
                      onTap: () async {
                        var data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day),
                        );
                        if (data != null) {
                          dataNascimentoController.text = data.toString();
                          perfilModel.dataNascimento = data;
                        }
                      },
                    ),
                    const TextLabel(
                      texto: "Nível de experiência",
                    ),
                    Column(
                      children: niveis
                          .map(
                            (nivel) => RadioListTile(
                              title: Text(nivel.toString()),
                              selected: perfilModel.nivelExperiencia == nivel,
                              value: nivel.toString(),
                              groupValue: perfilModel.nivelExperiencia,
                              onChanged: (value) {
                                setState(() {
                                  perfilModel.nivelExperiencia =
                                      value.toString();
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const TextLabel(
                      texto: "Linguagem de Programação",
                    ),
                    Column(
                      children: linguagens
                          .map(
                            (linguagem) => CheckboxListTile(
                              title: Text(linguagem.toString()),
                              value: perfilModel.linguagens.contains(linguagem),
                              onChanged: (value) {
                                if (value == true) {
                                  perfilModel.linguagens.add(linguagem);
                                } else {
                                  perfilModel.linguagens.remove(linguagem);
                                }
                                setState(() {});
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const TextLabel(
                      texto: "Tempo de Experiência",
                    ),
                    DropdownButton(
                      value: perfilModel.tempoExperiencia,
                      isExpanded: true,
                      items: retornaItens(50),
                      onChanged: (value) {
                        setState(() {
                          perfilModel.tempoExperiencia =
                              int.parse(value.toString());
                        });
                        debugPrint(perfilModel.tempoExperiencia.toString());
                      },
                    ),
                    TextLabel(
                      texto:
                          "Pretensão salarial R\$ ${perfilModel.salario?.round().toString()}",
                    ),
                    Slider(
                      min: 0,
                      max: 50000,
                      value: perfilModel.salario ?? 0,
                      onChanged: (value) {
                        setState(() {
                          perfilModel.salario = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("O nome deve ter no mínimo 3 caracters"),
                            ),
                          );
                          return;
                        }
                        if (perfilModel.dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data de nascimento inválida!"),
                            ),
                          );
                          return;
                        }
                        if (perfilModel.nivelExperiencia == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Um nível deve ser escolhido"),
                            ),
                          );
                          return;
                        }
                        if (perfilModel.linguagens.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Uma linguagem deve ser escolhida"),
                            ),
                          );
                          return;
                        }
                        if ((perfilModel.salario ?? 0) < 1500) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "A pretenção salarial deve ser maior que R\$ 1.500,00"),
                            ),
                          );
                          return;
                        }

                        perfilModel.nome = nomeController.text;
                        perfilRepository.salvar(perfilModel);

                        setState(() {
                          salvando = true;
                        });

                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Dados salvo com sucesso"),
                              ),
                            );
                            setState(() {
                              salvando = false;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: const TextLabel(texto: "Salvar"),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
