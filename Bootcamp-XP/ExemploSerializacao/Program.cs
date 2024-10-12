
using ExemploSerializacao.Models;
using Newtonsoft.Json;

List<Vendas> listaVendas = new List<Vendas>();

DateTime dataVenda = DateTime.Now;

Vendas v1 = new Vendas(1, "Material de Escritório", 25.00M, dataVenda);
Vendas v2 = new Vendas(2, "Material de Limpeza", 55.00M, dataVenda);

listaVendas.Add(v1);
listaVendas.Add(v2);

string serializado = JsonConvert.SerializeObject(listaVendas, Formatting.Indented);

File.WriteAllText("Arquivos/vendas.json",serializado);

Console.WriteLine("Fim");