import 'package:flutter/material.dart';
import 'package:myapprandom/repository/linguagens_repository.dart';
import 'package:myapprandom/repository/nivel_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/widgets/text_label.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var nivelSelecionado = "";
  var niveis = [];

  var linguagensRepository = LinguagensRepository();
  List<String> linguagemSelecionada = [];
  var linguagens = [];

  double salarioEscolhido = 0;
  int tempoExperiencia = 0;
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

  late SharedPreferences storage;

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
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = storage.getString(CHAVE_PERFIL_NOME_USUARIO) ?? '';
      dataNascimentoController.text =
          storage.getString(CHAVE_PERFIL_DATA_NASCIMENTO) ?? '';
      dataNascimento = DateTime.parse(dataNascimentoController.text);
      nivelSelecionado =
          storage.getString(CHAVE_PERFIL_NIVEL_EXPERIENCIA) ?? '';
      linguagemSelecionada =
          storage.getStringList(CHAVE_PERFIL_lINGUAGENS_PROGRAMACAO) ?? [];
      tempoExperiencia = storage.getInt(CHAVE_PERFIL_TEMPO_EXPERIENCIA) ?? 0;
      salarioEscolhido = storage.getDouble(CHAVE_PERFIL_SALARIO) ?? 0;
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
                          dataNascimento = data;
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
                              selected: nivelSelecionado == nivel,
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  nivelSelecionado = value.toString();
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
                              value: linguagemSelecionada.contains(linguagem),
                              onChanged: (value) {
                                if (value == true) {
                                  linguagemSelecionada.add(linguagem);
                                } else {
                                  linguagemSelecionada.remove(linguagem);
                                }
                                setState(() {});
                                debugPrint(linguagemSelecionada.toString());
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const TextLabel(
                      texto: "Tempo de Experiência",
                    ),
                    DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: retornaItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                        debugPrint(tempoExperiencia.toString());
                      },
                    ),
                    TextLabel(
                      texto:
                          "Pretensão salarial R\$ ${salarioEscolhido.round().toString()}",
                    ),
                    Slider(
                      min: 0,
                      max: 50000,
                      value: salarioEscolhido,
                      onChanged: (value) {
                        setState(() {
                          salarioEscolhido = value;
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
                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data de nascimento inválida!"),
                            ),
                          );
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Um nível deve ser escolhido"),
                            ),
                          );
                          return;
                        }
                        if (linguagemSelecionada.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Uma linguagem deve ser escolhida"),
                            ),
                          );
                          return;
                        }
                        if (salarioEscolhido < 1500) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "A pretenção salarial deve ser maior que R\$ 1.500,00"),
                            ),
                          );
                          return;
                        }

                        await storage.setString(
                            CHAVE_PERFIL_NOME_USUARIO, nomeController.text);
                        await storage.setString(CHAVE_PERFIL_DATA_NASCIMENTO,
                            dataNascimentoController.text);
                        await storage.setString(
                            CHAVE_PERFIL_NIVEL_EXPERIENCIA, nivelSelecionado);
                        await storage.setStringList(
                            CHAVE_PERFIL_lINGUAGENS_PROGRAMACAO,
                            linguagemSelecionada);
                        await storage.setInt(
                            CHAVE_PERFIL_TEMPO_EXPERIENCIA, tempoExperiencia);
                        await storage.setDouble(
                            CHAVE_PERFIL_SALARIO, salarioEscolhido);

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
