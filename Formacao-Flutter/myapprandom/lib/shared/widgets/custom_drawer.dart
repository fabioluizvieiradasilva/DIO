import 'package:flutter/material.dart';
import 'package:myapprandom/pages/configuracao/configuracao_hive_page.dart';
import 'package:myapprandom/pages/login_page.dart';
import 'package:myapprandom/pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';

import '../../pages/perfil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera_alt),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.photo_album),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  "https://hermes.digitalinnovation.one/assets/diome/logo.png",
                ),
              ),
              accountName: const Text("Fabio Vieira"),
              accountEmail: const Text("email@email.com"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Perfil"),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              debugPrint("Cursos");
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.book),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Cursos"),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NumerosAleatoriosHivePage()));
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.numbers),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Numeros Aleatórios"),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConfiguracaoHivePage()));
              debugPrint("Configurações");
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.engineering),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Configurações"),
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: const Text("My App"),
                      content: const Wrap(
                        children: [
                          Text("Deseja sair do aplicativo?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sair"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
