import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';

class FerramentasObra extends StatefulWidget {
  const FerramentasObra({super.key, required this.obra});
  final Map obra;
  @override
  State<FerramentasObra> createState() => _FerramentasObraState();
}

class _FerramentasObraState extends State<FerramentasObra> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas da Obra'),
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
                  .child('ferramentas'),
              itemBuilder: (context, snapshot, animation, index) {
                Map ferramenta = snapshot.value as Map;
                ferramenta['key'] = snapshot.key;
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
                                ferramenta['ferramenta'],
                                style: pTitulo,
                              ),
                              Text(
                                ferramenta['detalhes'],
                                style: pTitulo,
                              ),
                            ],
                          ),
                          Text('x${ferramenta['quantidade']}')
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
