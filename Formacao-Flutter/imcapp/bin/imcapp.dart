import 'dart:convert';
import 'dart:io';

import 'package:imcapp/classes/pessoa.dart';

void main(List<String> arguments) {
  var p1 = Pessoa();
  print("Insira o nome da pessoa: ");
  var nome = stdin.readLineSync(encoding: utf8);

  print("Insira o peso: ");
  var peso = stdin.readLineSync(encoding: utf8);

  print("Insira o altura: ");
  var altura = stdin.readLineSync(encoding: utf8);

  p1.setNome(nome.toString());

  try {
    p1.setAltura(double.parse(altura ?? "0"));
    p1.setPeso(double.parse(peso ?? "0"));
    print(p1.getNome());
    print(p1.calcularIMC());
  } catch (e) {
    print("Erro ao setar altura ou peso!");
  }
}
