import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/widgets/item_equipamento.dart';
import 'package:flutter/material.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key});

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos> {
  List<ItemEquipamento> equipamentos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos'),
        centerTitle: true,
        backgroundColor: CustomColors.pink,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context);
        },
        backgroundColor: CustomColors.pink,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          for (var i in equipamentos)
            ItemEquipamento(
              equipamento: i.equipamento,
              numero: i.numero,
              descricao: i.descricao,
            )
        ],
      ),
    );
  }

  Future<dynamic> showModal(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();

    void clearAll() {
      nomeController.clear();
      idController.clear();
      descricaoController.clear();
    }

    return showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Wrap(
              children: [
                const SizedBox(height: 8.0),
                buildText(
                  nomeController,
                  'Equipamento',
                  Icons.handyman_rounded,
                  1,
                ),
                buildText(
                  idController,
                  'Número do Equipamento',
                  Icons.pin_outlined,
                  1,
                ),
                buildText(
                  descricaoController,
                  'Descrição',
                  Icons.description,
                  5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nomeController.text == '' ||
                            idController.text == '' ||
                            descricaoController.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Você precisa preencher todos os campos'),
                            ),
                          );
                          return;
                        }

                        setState(
                          () {
                            equipamentos.add(
                              ItemEquipamento(
                                equipamento: nomeController.text,
                                numero: idController.text,
                                descricao: descricaoController.text,
                              ),
                            );
                          },
                        );

                        clearAll();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.pink,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text('Salvar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding buildText(controller, String hint, IconData icon, maxLines) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: pDecoration,
        child: TextField(
          controller: controller,
          minLines: 1,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
