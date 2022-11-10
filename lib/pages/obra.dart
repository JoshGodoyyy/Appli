import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/data.dart';
import 'package:appli/customs/models/model.dart';
import 'package:appli/pages/adicionar_equipamento.dart';
import 'package:appli/widgets/item_equipamento.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../customs/enums/tipos.dart';
import '../customs/utilities/constants.dart';
import '../widgets/item.dart';
import 'adicionar_ferramenta.dart';

class NovaObra extends StatefulWidget {
  const NovaObra({super.key, required this.obra});

  final Local obra;

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
    enderecoController.text = widget.obra.endereco;
  }

  String tipo() {
    switch (tipos) {
      case Tipos.obra:
        return 'Obra';
      default:
        return 'Empresa';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.obra.titulo),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tipos == null) {
            showSnack('Você deve selecionar o tipo de obra');
            return;
          }
          databaseReference.child('obras').push()
            ..child('dados').set({
              'obra': widget.obra.titulo,
              'tipo': tipo(),
              'endereco': enderecoController.text.trim(),
            })
            ..child('ferramentas').set(
                Model.instance.ferramentas.map((e) => e.toJson()).toList());
          Model.instance.ferramentas.clear();

          Navigator.pop(context);
          showSnack('Cadastrada com sucesso');
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
            for (var i in Model.instance.ferramentas)
              Item(
                i: i,
                onDelete: onDeleteFerramenta,
              ),
            const SizedBox(height: 8.0),
            buildButton(
              context,
              'Adicionar equipamento',
              const AdicionarEquipamento(),
            ),
            for (var i in Model.instance.equipamentos)
              ItemEquipamentoLista(i: i, onDelete: onDeleteEquipamento)
          ],
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context, String text, func) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => func,
                ),
              )
              .then((value) => setState(() {})),
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

  void onDeleteFerramenta(Ferramenta ferramenta) {
    setState(() {
      Model.instance.ferramentas.remove(ferramenta);
    });
  }

  void onDeleteEquipamento(Equipamento equipamento) {
    setState(() {
      Model.instance.equipamentos.remove(equipamento);
    });
  }

  showSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
