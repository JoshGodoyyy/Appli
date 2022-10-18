import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/list_item.dart';

class Funcionarios extends StatefulWidget {
  const Funcionarios({super.key});

  @override
  State<Funcionarios> createState() => _FuncionariosState();
}

class _FuncionariosState extends State<Funcionarios> {
  List<ListItem> funcionarios = [];
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController funcaoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        backgroundColor: CustomColors.deepPurple,
        centerTitle: true,
      ),
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          buildText(
            nomeController,
            'Nome',
            Icons.person,
          ),
          buildText(
            funcaoController,
            'Função',
            Icons.home_repair_service_rounded,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (nomeController.text == '' ||
                      funcaoController.text == '') {
                    showSnack('Você precisa digitar um nome e função');
                    return;
                  }

                  setState(() {
                    funcionarios.add(
                      ListItem(
                          nome: nomeController.text,
                          funcao: funcaoController.text),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: CustomColors.deepPurple,
                ),
                child: const Text(
                  'Adicionar',
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var i in funcionarios)
                  ListItem(nome: i.nome, funcao: i.funcao)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildText(
      TextEditingController nomeController, String nome, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: pDecoration,
        child: TextField(
          controller: nomeController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon),
            hintText: nome,
          ),
        ),
      ),
    );
  }

  void showSnack(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
