import 'package:flutter/material.dart';
import 'package:myapprandom/model/configuracoes_model.dart';
import 'package:myapprandom/repository/configuracoes_repository.dart';

class ConfiguracaoHivePage extends StatefulWidget {
  const ConfiguracaoHivePage({super.key});

  @override
  State<ConfiguracaoHivePage> createState() => _ConfiguracaoHivePageState();
}

class _ConfiguracaoHivePageState extends State<ConfiguracaoHivePage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  //late SharedPreferences storage;
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  final CHAVE_NOME_USUARIO = 'nome_usuario';
  final CHAVE_ALTURA_USUARIO = 'altura_usuario';
  final CHAVE_NOTIFICACAO = 'notificacao';
  final CHAVE_TEMA_ESCURO = 'tema_escuro';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Configurações - Hive"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: nomeUsuarioController,
                  decoration:
                      const InputDecoration(hintText: 'Nome do Usuário'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: 'Altura do Usuário'),
                ),
              ),
              SwitchListTile(
                value: configuracoesModel.receberNotificacao,
                title: const Text('Receber Notificação'),
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.receberNotificacao = value;
                  });
                },
              ),
              SwitchListTile(
                value: configuracoesModel.temaEscuro,
                title: const Text('Tema Escuro'),
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.temaEscuro = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                  try {
                    configuracoesModel.altura =
                        double.parse(alturaController.text);
                  } catch (e) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("My App"),
                            content: const Text("Valor de altura inválido!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              )
                            ],
                          );
                        },
                      );
                    }
                    return;
                  }
                  configuracoesRepository.salvar(configuracoesModel);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Salvar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();

    setState(() {
      nomeUsuarioController.text = configuracoesModel.nomeUsuario;
      alturaController.text = configuracoesModel.altura.toString();
    });
  }
}
