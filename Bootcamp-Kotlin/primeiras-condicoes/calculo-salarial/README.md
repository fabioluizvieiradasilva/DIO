# Desafio
Faça um programa que calcule e imprima o salário a ser transferido para um funcionário. Para realizar o calculo, primeiro receba o valor do salário bruto (valorSalario) e adicional dos benefícios (valorBeneficios). Por fim, o salário a ser transferido é calculado da seguinte maneira: 

(valorSalario - valorImpostos) + valorBeneficios

Para calcular o valorImpostos, seguem as aliquotas (baseadas no valor do salário bruto):

    De R$ 0.00 a R$ 1100.00 = 5.00%
    De R$ 1100.01 a R$ 2500.00 = 10.00%
    Maior que R$ 2500.00 = 15.00%

# Entrada
A entrada consiste em vários arquivos de teste, que conterá o valor do salário bruto (valorSalario) e adicional dos benefícios (valorBeneficios). Conforme mostrado no exemplo de entrada a seguir.

# Saída
Para cada conjunto de Entradas (valorSalario e valorBeneficios), deverá ser calculada uma Saída. Para isso, basta imprimir uma linha com o resultado da seguinte fórmula:

saida = (valorSalario - valorImpostos) + valorBeneficios

Use o exemplo abaixo para entender melhor a formatação das Entradas e Saída.

Exemplos
A tabela abaixo apresenta exemplos com alguns dados de entrada e suas respectivas saídas esperadas. Certifique-se de testar seu programa com esses exemplos e com outros casos possíveis.  
  
  |Entrada|Saída|
  |-------|-----|
  |2000 <br>250| 2050|
  |1100 <br> 50| 1045|
  |3000<br>400|2960|
  


