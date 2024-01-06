fun main() {
  val urls = mutableListOf<String>()

  while (true) {
    val input = readLine() ?: break
    if (input.isBlank()) break
    urls.add(input)
  }

  println("Iniciando downloads...")

  // Cria uma lista de Pair (indice, tamanho)
  val results = mutableListOf<Pair<Int, Int>>()

  // Em Kotlin, Coroutines são uma opção mais idiomática e simples para operações assíncronas
  // e paralelas em comparação com Threads. No entanto, nosso editor de código atual
  // ainda não suporta Coroutines. Para mais detalhes, veja a documentação oficial:
  // https://kotlinlang.org/docs/coroutines-overview.html
  val threads = urls.mapIndexed { index, url ->
    Thread {
      val length = openLink(url)
      synchronized(results) {
        results.add(Pair(index, length))
      }
    }
  }

    //TODO("Inicie cada Thread para começar o processo de 'download' paralelamente.")
    threads.forEach { it.start() }
    //TODO("Aguarde até que todas as Threads terminem suas respectivas execuções.")
    threads.forEach { it.join() }

  // Ordena os resultados por índice para imprimir na ordem correta
  results.sortedBy { it.first }.forEachIndexed { idx, result ->
    println("Arq${idx + 1}: ${result.second}")
  }
  println("Tempo total: ${urls.size}")
}

// Simula a abertura de uma URL, retornando seu tamanho.
fun openLink(url: String): Int {
    return url.length
}