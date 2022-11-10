import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class WidgetEquipamento extends StatelessWidget {
  const WidgetEquipamento({
    Key? key,
    required this.equipamento,
    required this.onDelete,
  }) : super(key: key);

  final Map equipamento;
  final Function(Map) onDelete;

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
                onDelete(equipamento['']);
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
                Text(equipamento['equipamento'], style: pTitulo),
                Text(equipamento['descricao']),
                Text(equipamento['numero']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
