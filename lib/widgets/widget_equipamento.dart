import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('equipamentos');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Atenção'),
                        content: const Text('Deseja mesmo apagar este item?'),
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
                    });
              },
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              label: 'Remover',
              icon: Icons.delete_rounded,
            )
          ],
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 7,
          child: InkWell(
            onTap: () => widget.onTap(widget.equipamento),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.equipamento['equipamento'], style: pTitulo),
                    Text(widget.equipamento['descricao']),
                    Text(widget.equipamento['numero']),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
