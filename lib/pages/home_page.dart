import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/enums/tipos.dart';
import 'package:appli/pages/equipamentos.dart';
import 'package:appli/pages/estoque.dart';
import 'package:appli/pages/ferramentas.dart';
//import 'package:appli/pages/locais.dart';
import 'package:appli/pages/login.dart';
import 'package:appli/widgets/local.dart';
import 'package:flutter/material.dart';

import '../widgets/horizontal_calendar.dart';
import '../widgets/item_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.deepPurple,
        elevation: 0,
        title: const Text('AppLi'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Olá, nome

          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: CustomColors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Olá, Josh',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //Lista de ações

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 5),
                    blurRadius: 7,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  ItemButton(
                    title: 'Ferramentas',
                    icon: Icons.hardware_rounded,
                    color: CustomColors.deepBlue,
                    onTap: () => onTap(
                      MaterialPageRoute(
                        builder: (context) => const Ferramentas(),
                      ),
                    ),
                  ),
                  ItemButton(
                    title: 'Estoque',
                    icon: Icons.inventory,
                    color: CustomColors.orange,
                    onTap: () => onTap(
                      MaterialPageRoute(
                        builder: (context) => const Estoque(),
                      ),
                    ),
                  ),
                  ItemButton(
                    title: 'Equipamentos',
                    icon: Icons.handyman_rounded,
                    color: CustomColors.pink,
                    onTap: () => onTap(
                      MaterialPageRoute(
                        builder: (context) => const Equipamentos(),
                      ),
                    ),
                  ),
                  ItemButton(
                    title: 'Funcionários',
                    icon: Icons.group,
                    color: CustomColors.deepPurple,
                    onTap: () => onTap(
                      MaterialPageRoute(
                        builder: (context) => const Equipamentos(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'Locais',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Local(
                    titulo: 'Terreno',
                    endereco: 'Estrada de Servidão Sete',
                    tipo: Tipos.empresa),
                const Local(
                    titulo: 'Terreno 1',
                    endereco: 'Travessa Linda Darnel',
                    tipo: Tipos.empresa),
                const Local(
                    titulo: 'Maccris',
                    endereco: 'Rua Juquiá - Santo André',
                    tipo: Tipos.obra),
                const Local(
                    titulo: 'Recon',
                    endereco: 'Rua Paraguai - Santo André',
                    tipo: Tipos.obra),
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
          )
        ],
      ),
    );
  }

  void onTap(Route route) {
    Navigator.of(context).push(route);
  }
}
