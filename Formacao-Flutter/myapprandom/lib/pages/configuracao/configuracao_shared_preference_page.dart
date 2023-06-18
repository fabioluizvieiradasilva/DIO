import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracaoSharedPreferencePage extends StatefulWidget {
  const ConfiguracaoSharedPreferencePage({super.key});

  @override
  State<ConfiguracaoSharedPreferencePage> createState() =>
      _ConfiguracaoSharedPreferencePageState();
}

class _ConfiguracaoSharedPreferencePageState
    extends State<ConfiguracaoSharedPreferencePage> {
  String? nomeUsuario;
  double? altura;
  bool notificacao = false;
  bool temaEscuro = false;

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  late SharedPreferences storage;

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
          title: const Text("Configurações"),
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
                value: notificacao,
                title: const Text('Receber Notificação'),
                onChanged: (bool value) {
                  setState(() {
                    notificacao = value;
                  });
                },
              ),
              SwitchListTile(
                value: temaEscuro,
                title: const Text('Tema Escuro'),
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  await storage.setString(
                      CHAVE_NOME_USUARIO, nomeUsuarioController.text);
                  try {
                    await storage.setDouble(CHAVE_ALTURA_USUARIO,
                        double.parse(alturaController.text));
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

                  await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);
                  await storage.setBool(CHAVE_NOTIFICACAO, notificacao);
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
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(CHAVE_NOME_USUARIO) ?? '';
      alturaController.text =
          (storage.getDouble(CHAVE_ALTURA_USUARIO) ?? 0).toString();
      notificacao = storage.getBool(CHAVE_NOTIFICACAO) ?? false;
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
    });
  }
}
