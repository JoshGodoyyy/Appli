import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';
import '../../customs/utilities/constants.dart';
import '../../firebase_options.dart';

class EquipamentosObra extends StatefulWidget {
  const EquipamentosObra({super.key, required this.obra});
  final Map obra;

  @override
  State<EquipamentosObra> createState() => _EquipamentosObraState();
}

class _EquipamentosObraState extends State<EquipamentosObra> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos da Obra'),
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
                  .child('equipamentos'),
              itemBuilder: (context, snapshot, animation, index) {
                Map equipamento = snapshot.value as Map;
                equipamento['key'] = snapshot.key;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: pDecoration,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            equipamento['equipamento'],
                            style: pTitulo,
                          ),
                          Text(
                            'Descrição: ${equipamento['detalhes']}',
                            style: pTitulo,
                          ),
                          Text(
                            'Patrimônio n°: ${equipamento['numero']}',
                            style: pTitulo,
                          )
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
