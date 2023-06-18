import 'package:flutter/material.dart';
import 'package:myapprandom/pages/card_page.dart';
import 'package:myapprandom/pages/tarefa/tarefa_hive_page.dart';

import '../shared/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController();
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main app"),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                  TarefaHivePage(),
                  CardPage(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                    label: "Tarefas",
                    icon: Icon(Icons.task),
                  ),
                  BottomNavigationBarItem(
                    label: "Teste",
                    icon: Icon(Icons.list),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
