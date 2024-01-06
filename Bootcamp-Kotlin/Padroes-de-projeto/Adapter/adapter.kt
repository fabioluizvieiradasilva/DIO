// Antiga classe de conversão que só suporta a conversão de USD para GBP
class OldCurrencyConverter {
  fun convertUSDtoGBP(amount: Double): Double {
    return amount * 0.80 // 80% do valor em USD
  }
}

// Novo adaptador que usa a antiga conversão e aplica a taxa adicional de GBP para EUR
class CurrencyAdapter(private val oldConverter: OldCurrencyConverter) {
  fun convertUSDtoEUR(amount: Double): Double {
    //TODO("Implementar a lógica de adaptação usando o $oldConverter e taxa definida no enunciado.")
    val amountGBP = oldConverter.convertUSDtoGBP(amount)
    val amountEUR = amountGBP * 1.0625 // 85% do valor do USD
    return amountEUR
  }
}

fun main() {
  val input = readLine()?.toDoubleOrNull() ?: return
  val oldConverter = OldCurrencyConverter()
  val adapter = CurrencyAdapter(oldConverter)

  val amountInEUR = adapter.convertUSDtoEUR(input)

  println("USD: $input")
  println("EUR: $amountInEUR")
}