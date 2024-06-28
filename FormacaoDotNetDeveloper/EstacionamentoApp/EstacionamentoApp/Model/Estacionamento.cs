using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EstacionamentoApp.Model
{
    public class Estacionamento
    {
        private decimal PrecoHora { get; set; }
        private decimal PrecoInicial { get; set; }

        public Estacionamento(decimal precoHora, decimal precoInicial )
        {
            this.PrecoHora = precoHora;
            this.PrecoInicial = precoInicial;
        }


    }
}
