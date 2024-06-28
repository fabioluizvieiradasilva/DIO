// See https://aka.ms/new-console-template for more information



using EstacionamentoApp.Model;

Estacionamento estacionamento;
bool sair=false;


Menu();

while(sair == false)
{
    Menu();
    var opcao = Console.ReadLine();
    switch (opcao)
    {
        case "1":
            Cadastrar();
            break;
        case "2":
            Listar();
            break;
        case "3":
        case "4":
            sair = true;
            break;
        default:
            Console.Write("Opção inválida!");
            break;
    }
}

void Menu()
{
    Console.Clear();
    Console.WriteLine("1 - Cadastrar Veículo");
    Console.WriteLine("2 - Listar Veículo");
    Console.WriteLine("3 - Remover Veículo");
    Console.WriteLine("4 - Sair");
}

void Cadastrar()
{
    Console.Clear();
    Console.Write("Informe a placa do veículo: ");
    var placa = Console.ReadLine();
    Console.Write("Informe o modelo: ");
    var modelo = Console.ReadLine();
    Veiculo.AdicionarVeiculo(placa, modelo);
}

void Listar()
{
    Console.Clear();
    var veiculos = Veiculo.ListarVeiculos();
    foreach (var item in veiculos)
    {
        Console.WriteLine($"Placa:{item.Placa}");
        Console.WriteLine($"Placa:{item.Modelo}");
        Console.WriteLine("-----------------------");
    }
    Console.ReadKey();
}

void Remover()
{
    Console.Clear();
    Console.WriteLine("Informe a placa do veículo:");
    var placa = Console.ReadLine();

    Veiculo.
}

void Iniciar()
{
    Console.Clear();
    Console.Write("Informe o preço inicial: ");
    var precoInicial = Convert.ToDecimal( Console.ReadLine());
    Console.Write("Informe o preço por hora: ");
    var precoHora = Convert.ToDecimal( Console.ReadLine());
    estacionamento = new Estacionamento(precoHora, precoInicial);

}


