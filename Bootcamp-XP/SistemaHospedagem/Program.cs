

using SistemaHospedagem.Models;

Pessoa p1 = new Pessoa("Fabio Luiz","Vieira da Silva");
Pessoa p2 = new Pessoa("José","Vieira da Silva");

List<Pessoa> hospedes = new List<Pessoa>();
hospedes.Add(p1);
hospedes.Add(p2);

Suite suite = new Suite(tipoSuite:"Presidencial", capacidade:2, valorDiaria: 30.00M);

Reserva reserva = new Reserva(hospedes: hospedes, suite: suite, diasReservados:5);

reserva.CadastrarSuite(suite);
reserva.CadastrarHospedes(hospedes);

Console.WriteLine($"Total de hospedes {reserva.ObterQuantidadeHospedes()}");
Console.WriteLine($"Valor Total da Diária {reserva.CalcularValorDiaria()}");
