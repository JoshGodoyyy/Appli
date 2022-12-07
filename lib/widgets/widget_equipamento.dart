import 'package:appli/customs/utilities/constants_menu.dart';
import 'package:appli/pages/relatorio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../customs/utilities/constants.dart';

class WidgetEquipamento extends StatefulWidget {
  const WidgetEquipamento({
    Key? key,
    required this.equipamento,
    required this.onTap,
  }) : super(key: key);

  final Map equipamento;
  final Function(Map) onTap;

  @override
  State<WidgetEquipamento> createState() => _WidgetEquipamentoState();
}

class _WidgetEquipamentoState extends State<WidgetEquipamento> {
  static const List<String> menuItem = [
    ConstantsMenu.editar,
    ConstantsMenu.relatorio,
    ConstantsMenu.remover
  ];

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('equipamentos');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: pContainer(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.equipamento['equipamento'], style: pTitulo),
                    Text(widget.equipamento['descricao']),
                    Text(widget.equipamento['numero']),
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case ConstantsMenu.editar:
                        widget.onTap(widget.equipamento);
                        break;
                      case ConstantsMenu.relatorio:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                Relatorio(item: widget.equipamento),
                          ),
                        );
                        break;
                      case ConstantsMenu.remover:
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Atenção'),
                              content:
                                  const Text('Deseja mesmo apagar este item?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    databaseReference
                                        .child(widget.equipamento['key'])
                                        .remove();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sim'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Não'),
                                ),
                              ],
                            );
                          },
                        );
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return menuItem.map(
                      (e) {
                        return PopupMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
