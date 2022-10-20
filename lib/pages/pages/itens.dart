import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/data.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../customs/models/locais.dart';
import '../../widgets/item_estoque.dart';

class Itens extends StatefulWidget {
  const Itens({super.key});

  @override
  State<Itens> createState() => _ItensState();
}

class _ItensState extends State<Itens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          for (var i in Locais.instance.itens)
            Item(
              itemEstoque: i,
              onDelete: onDelete,
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context);
        },
        backgroundColor: CustomColors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  void onDelete(ItemEstoque item) {
    setState(() {
      Locais.instance.itens.remove(item);
    });
  }

  Future<dynamic> showModal(BuildContext context) {
    TextEditingController itemController = TextEditingController();
    TextEditingController detalhesController = TextEditingController();
    TextEditingController quantidadeController = TextEditingController();

    void clearAll() {
      itemController.clear();
      detalhesController.clear();
      quantidadeController.clear();
    }

    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildText(
                  itemController,
                  'Item',
                  Icons.inbox_rounded,
                  TextInputType.text,
                ),
                buildText(
                  detalhesController,
                  'Detalhes',
                  Icons.details_rounded,
                  TextInputType.text,
                ),
                buildText(
                  quantidadeController,
                  'Quantidade',
                  Icons.inventory,
                  TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (itemController.text == '' ||
                            detalhesController.text == '' ||
                            quantidadeController.text == '') {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Você deve preencher todos os campos'),
                            ),
                          );

                          return;
                        }
                        setState(() {
                          ItemEstoque itemEstoque = ItemEstoque(
                            item: itemController.text,
                            detalhes: detalhesController.text,
                            quantidade: int.parse(quantidadeController.text),
                          );
                          Locais.instance.itens.add(itemEstoque);
                        });

                        clearAll();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: CustomColors.orange,
                      ),
                      child: const Text('Adicionar'),
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

  Padding buildText(
      controller, String hint, IconData icon, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: pDecoration,
        child: TextField(
          keyboardType: type,
          controller: controller,
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
