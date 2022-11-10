import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/model.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdicionarEquipamento extends StatefulWidget {
  const AdicionarEquipamento({super.key});

  @override
  State<AdicionarEquipamento> createState() => _AdicionarEquipamentoState();
}

class _AdicionarEquipamentoState extends State<AdicionarEquipamento> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Query data = FirebaseDatabase.instance.ref().child('equipamentos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos'),
        centerTitle: true,
        backgroundColor: CustomColors.lightOrange,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Model.instance.equipamentos.clear();

          for (var i in Model.instance.equipamentos) {
            print('${i.equipamento}, ${i.numero}, ${i.detalhes}');
          }

          Equipamento e = Equipamento(
              equipamento: 'Lixadeira', numero: 159753, detalhes: '7"');

          setState(() {
            Model.instance.equipamentos.remove(
              e,
            );
          });

          print(Model.instance.equipamentos.length);
        },
        icon: const Icon(Icons.save),
        label: const Text('Salvar'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: data,
              itemBuilder: (context, snapshot, animation, index) {
                Map item = snapshot.value as Map;
                item['key'] = snapshot.key;
                return ItemEquipamento(item: item);
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

class ItemEquipamento extends StatefulWidget {
  const ItemEquipamento({Key? key, required this.item}) : super(key: key);

  final Map item;

  @override
  State<ItemEquipamento> createState() => _ItemEquipamentoState();
}

class _ItemEquipamentoState extends State<ItemEquipamento> {
  bool selecionado = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: pDecoration,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: selecionado,
                onChanged: (value) {
                  setState(() {
                    selecionado = value!;
                    if (selecionado == true) {
                      Model.instance.equipamentos.add(Equipamento(
                        equipamento: widget.item['equipamento'],
                        numero: int.parse(widget.item['numero']),
                        detalhes: widget.item['descricao'],
                      ));
                    } else {
                      Model.instance.equipamentos.remove(Equipamento(
                        equipamento: widget.item['equipamento'],
                        numero: int.parse(widget.item['numero']),
                        detalhes: widget.item['descricao'],
                      ));
                      print(Model.instance.equipamentos.length);
                    }
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['equipamento'],
                    style: pTitulo,
                  ),
                  Text('Detalhe: ${widget.item['numero']}'),
                  Text('Nº Patrimônio: ${widget.item['descricao']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
