import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:appli/widgets/widget_equipamento.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key});

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos> {
  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  Query data = FirebaseDatabase.instance.ref().child('equipamentos');

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
          showModal(context, null, 'Adicionar');
        },
        backgroundColor: CustomColors.pink,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: data,
              itemBuilder: (context, snapshot, animation, index) {
                Map equipamentos = snapshot.value as Map;
                equipamentos['key'] = snapshot.key;

                return WidgetEquipamento(
                  equipamento: equipamentos,
                  onTap: onTap,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void onTap(Map item) {
    showModal(context, item, 'Editar');
  }

  Future<dynamic> showModal(
    BuildContext context,
    Map? item,
    String textoBotao,
  ) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController idController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();

    void init() {
      nomeController.text = item!['equipamento'];
      descricaoController.text = item['descricao'];
      idController.text = item['numero'];
    }

    void clearAll() {
      nomeController.clear();
      idController.clear();
      descricaoController.clear();
    }

    item == null ? null : init();

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

                        if (textoBotao == 'Adicionar') {
                          databaseReference
                              .child('equipamentos')
                              .child(
                                  '${nomeController.text}_${idController.text}')
                              .set({
                            'equipamento': nomeController.text,
                            'numero': idController.text,
                            'descricao': descricaoController.text
                          });
                        } else {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref('equipamentos')
                              .child(item!['key']);

                          ref.update({
                            'equipamento': nomeController.text,
                            'numero': idController.text,
                            'descricao': descricaoController.text
                          });

                          Navigator.pop(context);
                        }

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
