import 'dart:math';

class NumeroAleatorio {
  static int gerarNumeroAleatorio(int numeroMax) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMax);
  }
}
