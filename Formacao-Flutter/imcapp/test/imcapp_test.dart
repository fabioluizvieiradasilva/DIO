import 'dart:convert';
import 'dart:io';

import 'package:imcapp/classes/Pessoa.dart';
import 'package:test/test.dart';

void main() {
  test('altura', () {
    var p1 = Pessoa();
    p1.setAltura(1.82);
    p1.setPeso(80);

    var p2 = Pessoa();
    print("Altura:");
    p2.setAltura(double.parse(stdin.readLineSync(encoding: utf8) ?? "0"));
    print("Peso");
    p2.setPeso(double.parse(stdin.readLineSync(encoding: utf8) ?? "0"));

    expect(p2.calcularIMC(), p1.calcularIMC());
  });
}
