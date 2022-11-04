import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:appli/widgets/ferramenta.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Ferramentas extends StatefulWidget {
  const Ferramentas({super.key});

  @override
  State<Ferramentas> createState() => _FerramentasState();
}

class _FerramentasState extends State<Ferramentas> {
  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  Query data = FirebaseDatabase.instance.ref().child('ferramentas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas'),
        centerTitle: true,
        backgroundColor: CustomColors.deepBlue,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(context);
        },
        backgroundColor: CustomColors.deepBlue,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: data,
              itemBuilder: (context, snapshot, animation, index) {
                Map ferramentas = snapshot.value as Map;
                ferramentas['key'] = snapshot.key;
                return WidgetFerramenta(
                    ferramenta: ferramentas, onDelete: onDelete);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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
    TextEditingController ferramentaController = TextEditingController();
    TextEditingController detalhesController = TextEditingController();
    TextEditingController quantidadeController = TextEditingController();

    void clearAll() {
      ferramentaController.clear();
      detalhesController.clear();
      quantidadeController.clear();
    }

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Theme.of(context).backgroundColor,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  buildText(
                    ferramentaController,
                    'Ferramenta',
                    Icons.hardware,
                  ),
                  buildText(
                    detalhesController,
                    'Detalhes',
                    Icons.details_outlined,
                  ),
                  buildText(
                    quantidadeController,
                    'Quantidade',
                    Icons.inventory,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (ferramentaController.text == '' ||
                              detalhesController.text == '' ||
                              quantidadeController.text == '') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Você deve preencher todos os campos.'),
                              ),
                            );
                            return;
                          }

                          databaseReference
                              .child('ferramentas')
                              .child(ferramentaController.text)
                              .set({
                            'ferramenta': ferramentaController.text,
                            'detalhes': detalhesController.text,
                            'quantidade': quantidadeController.text
                          });

                          clearAll();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.deepBlue,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Text('Adicionar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
}
