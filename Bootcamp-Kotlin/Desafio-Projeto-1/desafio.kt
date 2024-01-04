enum class Nivel { BASICO, INTERMEDIARIO, AVANÇADO }

class Usuario(val nome: String)

data class ConteudoEducacional(val nome: String, val duracao: Int = 60)

data class Formacao(val nome: String, var conteudosEducacionais: MutableList<ConteudoEducacional>, val nivel: Nivel = Nivel.BASICO) {

    val inscritos = mutableListOf<Usuario>()
    
    fun matricular(usuario: Usuario) {        
        inscritos.add(usuario)
    }
}

fun main() {
    val usuario1 = Usuario("Usuario 1")
    val usuario2 = Usuario("Usuario 2")
    val usuario3 = Usuario("Usuario 3")
    val listaConteudos = mutableListOf<ConteudoEducacional>()
    val conteudosEducacionais1 = ConteudoEducacional("Noções básicas com Kotlin", 120)
    val conteudosEducacionais2 = ConteudoEducacional("POO com Kotlin", 120)
    val conteudosEducacionais3 = ConteudoEducacional("Construindo API com Kotlin", 180)
    listaConteudos.add(conteudosEducacionais1)
    listaConteudos.add(conteudosEducacionais2)
    listaConteudos.add(conteudosEducacionais3)
    val formacao = Formacao("Kotlin",listaConteudos, Nivel.AVANÇADO)
    formacao.matricular(usuario1)
    formacao.matricular(usuario2)
    formacao.matricular(usuario3)
    
    println("Usuários:")
    for(inscrito in formacao.inscritos){        
        println("${inscrito.nome}")
    }
    println()
    println("Formação: ${formacao.nome} - Nível: ${formacao.nivel}")
    for(conteudo in formacao.conteudosEducacionais){
        print("Conteúdo: ${conteudo.nome} - ")
        println("Duração: ${conteudo.duracao} minutos")
    }
}