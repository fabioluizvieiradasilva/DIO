using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EstacionamentoApp.Model
{
    public class Estacionamento
    {
        public decimal PrecoHora { get; set; }
        public decimal PrecoInicial { get; set; }

        public Estacionamento(decimal precoHora, decimal precoInicial )
        {
            this.PrecoHora = precoHora;
            this.PrecoInicial = precoInicial;
        }


    }
}
