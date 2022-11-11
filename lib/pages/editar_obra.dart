import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/pages/pages/dados_obra.dart';
import 'package:appli/pages/pages/equipamentos_obra.dart';
import 'package:appli/pages/pages/ferramentas_obra.dart';
import 'package:appli/pages/pages/funcionarios_obra.dart';
import 'package:flutter/material.dart';

class EditarObra extends StatefulWidget {
  const EditarObra({super.key, required this.obra});
  final Map obra;

  @override
  State<EditarObra> createState() => _EditarObraState();
}

class _EditarObraState extends State<EditarObra> {
  int paginaAtual = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: paginaAtual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          DadosObra(),
          FerramentasObra(),
          EquipamentosObra(),
          FuncionariosObra(),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.deepPurple,
        child: const Icon(Icons.check),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: CustomColors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.hardware,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.handyman_rounded,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.group,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
