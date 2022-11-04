import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/item_estoque.dart';

class Itens extends StatefulWidget {
  const Itens({super.key});

  @override
  State<Itens> createState() => _ItensState();
}

class _ItensState extends State<Itens> {
  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  Query data = FirebaseDatabase.instance.ref().child('epis');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: data,
              itemBuilder: ((context, snapshot, animation, index) {
                Map epis = snapshot.value as Map;
                epis['key'] = snapshot.key;

                return Item(
                  itemEstoque: epis,
                  onDelete: onDelete,
                );
              }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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

  void onDelete(Map) {
    setState(() {});
  }

  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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

                        databaseReference
                            .child('epis')
                            .child(itemController.text)
                            .set({
                          'item': itemController.text,
                          'detalhes': detalhesController.text,
                          'quantidade': quantidadeController.text
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
