// See https://aka.ms/new-console-template for more information



using EstacionamentoApp.Model;

bool sair=false;

while(sair == false)
{
    Console.Write("Informe a placa do veículo: ");
    var placa = Console.ReadLine();    
    Console.Write("Informe o modelo: ");
    var modelo = Console.ReadLine();
    Veiculo.AdicionarVeiculo(placa, modelo);
    var veiculos = Veiculo.ListarVeiculos();
    foreach (var item in veiculos)
    {
        Console.WriteLine($"Placa:{item.Placa}");
        Console.WriteLine($"Placa:{item.Modelo}");
    }
   
    Console.Write("Deseja cadastrar outro veículo?(S/N)");
    var resposta = Console.ReadLine();
    if(resposta.ToUpper() == "N")
        sair = true;
}

