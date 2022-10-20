import 'package:appli/customs/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class ItemEquipamento extends StatelessWidget {
  const ItemEquipamento({
    Key? key,
    required this.equipamento,
    required this.onDelete,
  }) : super(key: key);

  final Equipamento equipamento;
  final Function(Equipamento) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(equipamento);
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: pDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(equipamento.nome, style: pTitulo),
                Text('${equipamento.numero}'),
                Text(equipamento.descricao),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
