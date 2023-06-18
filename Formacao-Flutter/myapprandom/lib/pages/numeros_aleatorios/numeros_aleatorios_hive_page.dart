import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado = 0;
  int? numeroCliques = 0;

  final CHAVE_NUMERO_ALEATORIO = 'numero_aleatorio';
  final CHAVE_NUMERO_CLIQUES = 'numero_cliques';

  late Box storageBox;

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
          title: const Text("Números aleatórios - Hive"),
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
            storageBox.put(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
            storageBox.put(CHAVE_NUMERO_CLIQUES, numeroCliques!);
          },
          child: const Icon(Icons.generating_tokens),
        ),
      ),
    );
  }

  void carregarDados() async {
    if (Hive.isBoxOpen('box_numeros_aleatorio')) {
      storageBox = Hive.box('box_numeros_aleatorio');
    } else {
      storageBox = await Hive.openBox('box_numeros_aleatorio');
    }
    //storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storageBox.get(CHAVE_NUMERO_ALEATORIO) ?? 0;
      numeroCliques = storageBox.get(CHAVE_NUMERO_CLIQUES) ?? 0;
    });
  }
}
