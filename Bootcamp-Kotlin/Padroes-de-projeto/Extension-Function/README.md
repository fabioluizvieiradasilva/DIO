# Descrição
As Extension Functions, ou Funções de Extensão, são recursos poderosos disponíveis em linguagens de programação que permitem adicionar métodos a classes existentes sem a necessidade de modificar o código-fonte original dessas classes. Isso facilita a criação de novas funcionalidades ou comportamentos para tipos de dados já existentes, mesmo quando você não tem acesso ao código fonte original desses tipos.

Neste desafio, com foco em um sistema de gerenciamento de livros para uma biblioteca digital, você deve implementar uma solução que permita gerar um "slug" único para representar os dados de um livro. Um "slug" é uma versão simplificada e amigável para URLs de um texto, com espaços substituídos por traços (-) e caracteres especiais removidos. A solução requer que você crie uma função de extensão generateSlug() para a classe String que fará essa transformação.

# Funcionalidade a ser implementada:

generateSlug(): Crie uma função de extensão chamada generateSlug() para a classe String. A função deve gerar um "slug" para a string fornecida, removendo espaços e caracteres especiais, substituindo-os por traços.

# Entrada
A entrada consistirá em duas strings: o título e o autor de um livro.

# Saída
Imprima o "slug" gerado para o livro, no seguinte padrão:
Slug gerado para o livro:
nome-livro-separado-por-ifens_nome-autor-separado-por-ifens

# Exemplos
A tabela abaixo apresenta exemplos com alguns dados de entrada e suas respectivas saídas esperadas. Certifique-se de testar seu programa com esses exemplos e com outros casos possíveis.  

|Entrada|	Saída|
|-------|--------|
|Senhor dos Aneis<br>J. R. R Tolkien|Slug gerado para o livro:<br>senhor-dos-aneis_j-r-r-tolkien|
|O Enigma do Parque<br>Jody Shields|Slug gerado para o livro:<br>o-enigma-do-parque_jody-shields|
|O Chamado de Cthulhu<br>H. P. Lovecraft|Slug gerado para o livro:<br>o-chamado-de-cthulhu_h-p-lovecraft| 

# Nota:
O uso de extension functions tem seus pontos positivos, como a extensibilidade e organização do código, mas também apresenta desafios, como a possível confusão e a separação da lógica. A solução eficiente depende da linguagem de programação escolhida e das práticas de programação adotadas.  

Saiba mais sobre Extension Functions em Kotlin:
https://kotlinlang.org/docs/extensions.html#extension-functions