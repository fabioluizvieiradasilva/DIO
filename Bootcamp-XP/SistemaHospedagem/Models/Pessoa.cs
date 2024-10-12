
namespace SistemaHospedagem.Models
{
    public class Pessoa
    {
        public Pessoa(string nome, string sobrenome)        
        {
            this.Nome = nome;
            this.Sobrenome = sobrenome;
        }

        public string Nome { get; set; }
        public string Sobrenome { get; set; }
    }
}