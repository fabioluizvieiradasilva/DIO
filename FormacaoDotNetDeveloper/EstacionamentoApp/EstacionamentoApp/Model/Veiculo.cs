using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace EstacionamentoApp.Model
{
    public class Veiculo
    {
        public Guid Id { get; set; }
        public string Placa { get; set; }
        public string Modelo { get; set; }        
        
        private static List<Veiculo> Veiculos = new List<Veiculo>();

        public Veiculo(string placa)
        {
            this.Placa = placa;
        }

        public static void AdicionarVeiculo(string placa, string modelo)
        {
            Veiculo veiculo = new Veiculo(placa);
            
            veiculo.Id = Guid.NewGuid();
            veiculo.Modelo = modelo;
            
            Veiculos.Add(veiculo);            
            
        }

        public static List<Veiculo> ListarVeiculos()
        {
            List<Veiculo> veiculos = new List<Veiculo>();
            foreach (var item in Veiculos)
            {
                veiculos.Add(item);
            }
            return veiculos;
        }

        public static void Remover(string placa)
        {
            var veiculo = Veiculos.FirstOrDefault(x => x.Placa == placa);
            if(veiculo != null)
                Veiculos.Remove(veiculo);
        }
    }
}
