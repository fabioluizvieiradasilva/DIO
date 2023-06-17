import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatorios extends StatefulWidget {
  const NumerosAleatorios({super.key});

  @override
  State<NumerosAleatorios> createState() => _NumerosAleatoriosState();
}

class _NumerosAleatoriosState extends State<NumerosAleatorios> {
  int? numeroGerado = 0;
  int? numeroCliques = 0;

  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';
  final CHAVE_NUMERO_CLIQUES = 'numero_cliques';

  late SharedPreferences storage;

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
          title: const Text("Gerador de números aleatórios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null
                    ? "Nenhum número gerado"
                    : numeroGerado.toString(),
                style: const TextStyle(fontSize: 50),
              ),
              Text(
                numeroCliques == null
                    ? "Nenhum clique efetuado"
                    : numeroCliques.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              numeroCliques = numeroCliques == null ? 1 : numeroCliques! + 1;
            });
            await storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
            await storage.setInt(CHAVE_NUMERO_CLIQUES, numeroCliques!);
          },
          child: const Icon(Icons.generating_tokens),
        ),
      ),
    );
  }

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
      numeroCliques = storage.getInt(CHAVE_NUMERO_CLIQUES);
    });
  }
}
