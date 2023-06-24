import 'package:app_consulta_cep/model/cep_model.dart';
import 'package:app_consulta_cep/repository/cep_repository.dart';
import 'package:flutter/material.dart';

class QueryCEP extends StatefulWidget {
  const QueryCEP({super.key});

  @override
  State<QueryCEP> createState() => _QueryCEPState();
}

class _QueryCEPState extends State<QueryCEP> {
  var cepController = TextEditingController();
  var cepModel = CepModel();
  var cepRepository = CepRepository();

  var city = '';
  var uf = '';
  var address = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Consulta CEP"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: cepController,
                decoration: const InputDecoration(
                  hintText: "Informe o CEP",
                ),
              ),
              TextButton(
                onPressed: () async {
                  var cep = cepController.text;
                  cepModel = await cepRepository.getCep(cep);
                  //debugPrint(cepController.text);
                  // print("https://viacep.com.br/ws/$cep/json/");
                  // debugPrint(response.body);
                  // debugPrint(response.statusCode.toString());

                  // city = json["localidade"];
                  // uf = json["uf"];
                  // address = json["logradouro"];
                  setState(() {});
                },
                child: const Text("Consultar"),
              ),
              Text(
                cepModel.logradouro,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                "${cepModel.localidade} - ${cepModel.uf}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                cepModel.logradouro,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
