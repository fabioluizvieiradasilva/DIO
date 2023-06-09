class Pessoa {
  late String _nome;
  late double _altura;
  late double _peso;

  void setNome(String nome) {
    _nome = nome;
  }

  String getNome() {
    return _nome;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  double getAltura() {
    return _altura;
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  double getPeso() {
    return _peso;
  }

  double calcularIMC() {
    return _peso / (_altura * _altura);
  }
}
