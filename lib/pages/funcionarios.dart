import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/widgets/funcionario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class Funcionarios extends StatefulWidget {
  const Funcionarios({super.key});

  @override
  State<Funcionarios> createState() => _FuncionariosState();
}

class _FuncionariosState extends State<Funcionarios> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController funcaoController = TextEditingController();

  String textoBotao = 'Adicionar';

  late String path;

  final databaseReference = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://appli-cef3f-default-rtdb.firebaseio.com/',
  ).ref();

  Query data = FirebaseDatabase.instance.ref().child('funcionarios');

  void clearAll() {
    nomeController.clear();
    funcaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        backgroundColor: CustomColors.deepPurple,
        centerTitle: true,
      ),
      extendBody: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocorreu um erro'),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
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
                        if (textoBotao == 'Adicionar') {
                          databaseReference
                              .child('funcionarios')
                              .child(nomeController.text)
                              .set({
                            'nome': nomeController.text,
                            'funcao': funcaoController.text
                          });
                        } else {
                          DatabaseReference reference = FirebaseDatabase
                              .instance
                              .ref()
                              .child('funcionarios')
                              .child(path);

                          reference.update({
                            'nome': nomeController.text,
                            'funcao': funcaoController.text
                          });
                          clearAll();
                          setState(() => textoBotao = 'Adicionar');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: CustomColors.deepPurple,
                      ),
                      child: Text(
                        textoBotao,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: data,
                    itemBuilder: (
                      BuildContext context,
                      DataSnapshot snapshot,
                      Animation<double> animation,
                      int index,
                    ) {
                      Map funcionarios = snapshot.value as Map;
                      funcionarios['key'] = snapshot.key;
                      return WidgetFuncionario(
                          funcionario: funcionarios, onTap: onTap);
                    },
                  ),
                ),
              ],
            );
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
    nomeController.text = item['nome'];
    funcaoController.text = item['funcao'];
    setState(() => textoBotao = 'Editar');
    path = item['key'];
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
