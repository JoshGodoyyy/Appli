import 'package:flutter/material.dart';

import '../customs/colors/custom_colors.dart';
import '../customs/enums/tipos.dart';
import '../customs/utilities/constants.dart';
import '../widgets/item_button.dart';
import '../widgets/local.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    double height = 16.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.deepPurple,
        title: const Text('Ajuda'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          const Text(
            'Use o AppLi para controle e acompanhamento de obras.',
          ),
          SizedBox(height: height),
          const Text(
            'No menu abaixo, você tem acesso as telas para atualização e cadastro de novas ferramentas, controle e acompanhamento de estoque, equipamentos e cadastro de funcionários.',
          ),
          SizedBox(height: height),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  pShadow,
                ],
              ),
              child: Column(
                children: [
                  ItemButton(
                    title: 'Ferramentas',
                    icon: Icons.hardware_rounded,
                    color: CustomColors.deepBlue,
                    onTap: () {},
                  ),
                  ItemButton(
                    title: 'Estoque',
                    icon: Icons.inventory,
                    color: CustomColors.orange,
                    onTap: () {},
                  ),
                  ItemButton(
                    title: 'Equipamentos',
                    icon: Icons.handyman_rounded,
                    color: CustomColors.pink,
                    onTap: () {},
                  ),
                  ItemButton(
                    title: 'Funcionários',
                    icon: Icons.group,
                    color: CustomColors.deepPurple,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height),
          const Text(
              'Utilize o botão, abaixo da lista de endereços para cadastrar um novo local, este local é onde os equipamentos, ferramentas e funcionários poderão ser alocados.'),
          SizedBox(height: height),
          Column(
            children: [
              const Local(
                titulo: 'Titulo',
                endereco: 'Endereço',
                tipo: Tipos.obra,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add_circle_outline_rounded),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cadastrar Local'),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height),
          const Text(
              'Por fim, caso seja necessário realizar um login com outro usuário, utilize o botão na barra de títulos da tela inicial:'),
          SizedBox(height: height),
          const Center(
            child: Icon(
              Icons.logout,
              size: 42.0,
            ),
          ),
          const SizedBox(height: 54),
          const Center(
            child: Text(
              'Desenvolvido por Josué Lima e testado por Danieli Weirich.',
              style: TextStyle(color: Colors.black45),
            ),
          )
        ],
      ),
    );
  }
}
