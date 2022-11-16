import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';
import '../../customs/utilities/constants.dart';
import '../../firebase_options.dart';

class FuncionariosObra extends StatefulWidget {
  const FuncionariosObra({super.key, required this.obra});
  final Map obra;
  @override
  State<FuncionariosObra> createState() => _FuncionariosObraState();
}

class _FuncionariosObraState extends State<FuncionariosObra> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: FirebaseDatabase.instance
                  .ref()
                  .child('obras')
                  .child(widget.obra['key'])
                  .child('funcionarios'),
              itemBuilder: (context, snapshot, animation, index) {
                Map funcionario = snapshot.value as Map;
                funcionario['key'] = snapshot.key;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: pDecoration,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                funcionario['funcionario'],
                                style: pTitulo,
                              ),
                              Text(
                                funcionario['funcao'],
                                style: pTitulo,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
}
