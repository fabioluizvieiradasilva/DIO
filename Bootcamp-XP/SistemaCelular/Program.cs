// See https://aka.ms/new-console-template for more information
using SistemaCelular.Models;




Nokia nokia = new Nokia("999853214", "Modelo ABC", "KLASIAS8123817", 128);
nokia.Ligar();
nokia.ReceberLigacao();
nokia.InstalarAplicativo("Roblox");

Console.WriteLine("-----------------------");

Iphone iphone = new Iphone("9852314", "Modelo XYZ", "2834792sdfksçlf", 256);
iphone.Ligar();
iphone.ReceberLigacao();
iphone.InstalarAplicativo("Roblox");