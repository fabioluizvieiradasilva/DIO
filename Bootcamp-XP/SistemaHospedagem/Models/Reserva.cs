
namespace SistemaHospedagem.Models
{
    public class Reserva
    {
        public Reserva(List<Pessoa> hospedes, Suite suite, int diasReservados)
        {
            this.Hospedes = hospedes;
            this.Suite = suite;
            this.DiasReservados = diasReservados;
        }
        public List<Pessoa> Hospedes { get; set; }
        public Suite Suite { get; set; }
        public int DiasReservados { get; set; }

        public void CadastrarHospedes(List<Pessoa> hospedes)
        {
            
            if (Suite.Capacidade >= hospedes.Count)
            {
                this.Hospedes = hospedes;
            }
            else
            {
                throw new Exception("A quantidade de hospede é maior que a capacidade da suíte");
            }
            
        }

        public void CadastrarSuite(Suite suite)
        {
            Suite = suite;
        }

        public int ObterQuantidadeHospedes()
        {
            return Hospedes.Count;
        }

        public decimal CalcularValorDiaria()
        {
            decimal valorTotal = Suite.ValorDiaria * this.DiasReservados;            
            return this.DiasReservados < 10 ? valorTotal : valorTotal * 0.9M;
        }
    }
}