import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/data.dart';
import 'package:appli/pages/pages/adicionar_equipamento.dart';
import 'package:appli/pages/pages/adicionar_ferramenta.dart';
import 'package:appli/pages/pages/adicionar_funcionario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../customs/enums/tipos.dart';
import '../customs/utilities/constants.dart';

class NovaObra extends StatefulWidget {
  const NovaObra({super.key, required this.local});

  final Local local;

  @override
  State<NovaObra> createState() => _NovaObraState();
}

class _NovaObraState extends State<NovaObra> {
  TextEditingController enderecoController = TextEditingController();
  Tipos? tipos;

  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  @override
  void initState() {
    super.initState();
    enderecoController.text = widget.local.endereco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.local.titulo),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          databaseReference.child('obra').child(widget.local.titulo)
            ..child('ferramentas').set({
              'ferramenta': 'Ferramenta',
              'detalhes': 'Detalhes',
              'quantidade': 10
            })
            ..child('equipamentos').set({
              'equipamento': 'Equipamento',
              'numero': 123456,
              'detalhes': 'Detalhes',
            })
            ..child('funcionarios').set({
              'nome': 'Nome',
              'funcao': 'Funcao',
            });
        },
        backgroundColor: CustomColors.deepPurple,
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Center(
              child: Text(
                'Cadastrar nova obra',
                style: pTitulo,
              ),
            ),
            const SizedBox(height: 8.0),
            buildTextField(enderecoController, 'Endereço', Icons.pin_drop),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Tipo',
                    style: pTitulo,
                  ),
                  Row(
                    children: [
                      Radio<Tipos>(
                        value: Tipos.empresa,
                        groupValue: tipos,
                        onChanged: (Tipos? value) =>
                            setState(() => tipos = value),
                      ),
                      const Text('Empresa'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<Tipos>(
                        value: Tipos.obra,
                        groupValue: tipos,
                        onChanged: (Tipos? value) =>
                            setState(() => tipos = value),
                      ),
                      const Text('Obra'),
                    ],
                  ),
                ],
              ),
            ),
            buildButton(
              context,
              'Adicionar ferramenta',
              const AdicionarFerramenta(),
            ),
            buildButton(
              context,
              'Adicionar equipamento',
              const AdicionarEquipamento(),
            ),
            buildButton(
              context,
              'Selecionar funcionários',
              const AdicionarFuncionario(),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context, String text, Widget appWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).backgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: appWidget,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.deepPurple,
            padding: const EdgeInsets.all(16.0),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  Container buildTextField(controller, String hint, IconData icon) {
    return Container(
      decoration: pDecoration,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon),
          hintText: hint,
        ),
      ),
    );
  }
}
