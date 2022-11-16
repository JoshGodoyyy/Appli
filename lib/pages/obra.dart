import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/model.dart';
import 'package:appli/pages/adicionar_equipamento.dart';
import 'package:appli/pages/adicionar_funcionario.dart';
import 'package:appli/widgets/item_equipamento.dart';
import 'package:appli/widgets/item_obra.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../customs/enums/tipos.dart';
import '../customs/utilities/constants.dart';
import '../widgets/item.dart';
import 'adicionar_ferramenta.dart';

class NovaObra extends StatefulWidget {
  const NovaObra({super.key});

  @override
  State<NovaObra> createState() => _NovaObraState();
}

class _NovaObraState extends State<NovaObra> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  Tipos? tipos;

  DateTime? inicio, fim;

  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  String tipo() {
    switch (tipos) {
      case Tipos.obra:
        return 'Obra';
      default:
        return 'Empresa';
    }
  }

  String dataInicial = 'Selecionar';
  String dataFinal = 'Selecionar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tituloController.text.isEmpty) {
            showSnack('Você deve definir o nome da obra');
            return;
          }
          if (enderecoController.text.isEmpty) {
            showSnack('Você deve preencher o endereço da obra');
            return;
          }
          if (tipos == null) {
            showSnack('Você deve selecionar o tipo de obra');
            return;
          }
          if (dataInicial == 'Selecionar' || dataFinal == 'Selecionar') {
            showSnack('A obra deve ter data de início e finalização');
            return;
          }
          databaseReference.child('obras').push()
            ..child('dados').set({
              'obra': tituloController.text.trim(),
              'tipo': tipo(),
              'endereco': enderecoController.text.trim(),
              'dataInicial': inicio!.toString(),
              'previsaoEntrega': fim!.toString(),
              'entrega': fim!.toString(),
              'finalizada': false
            })
            ..child('ferramentas')
                .set(Model.instance.ferramentas.map((e) => e.toJson()).toList())
            ..child('equipamentos').set(
                Model.instance.equipamentos.map((e) => e.toJeysson()).toList())
            ..child('funcionarios').set(
                Model.instance.funcionarios.map((e) => e.toJson()).toList());

          Model.instance.ferramentas.clear();
          Model.instance.equipamentos.clear();
          Model.instance.funcionarios.clear();

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
            const Text(
              'Nome da obra:',
              style: pTitulo,
            ),
            const SizedBox(height: 8.0),
            buildTextField(tituloController, 'Obra', Icons.edit),
            const SizedBox(height: 8.0),
            const Text(
              'Endereço da obra:',
              style: pTitulo,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Início', style: pTitulo),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030),
                        locale: const Locale('pt', 'BR'),
                      ).then((value) {
                        int d, m, a;
                        d = value!.day;
                        m = value.month;
                        a = value.year;
                        inicio = value;
                        setState(() => dataInicial = '$d/$m/$a');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: CustomColors.deepPurple,
                    ),
                    child: Text(dataInicial),
                  ),
                ),
                const Text('Fim', style: pTitulo),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030),
                        locale: const Locale('pt', 'BR'),
                      ).then((value) {
                        int d, m, a;
                        d = value!.day;
                        m = value.month;
                        a = value.year;
                        fim = value;
                        setState(() => dataFinal = '$d/$m/$a');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: CustomColors.deepPurple,
                    ),
                    child: Text(dataFinal),
                  ),
                ),
              ],
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
              ItemEquipamentoLista(
                i: i,
                onDelete: onDeleteEquipamento,
              ),
            const SizedBox(height: 8.0),
            buildButton(
              context,
              'Selecionar funcionários',
              const AdicionarFuncionario(),
            ),
            for (var i in Model.instance.funcionarios)
              ItemObraLista(i: i, onDelete: onDeleteFuncionario)
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

  void onDeleteFuncionario(Funcionario funcionario) {
    setState(() {
      Model.instance.funcionarios.remove(funcionario);
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
