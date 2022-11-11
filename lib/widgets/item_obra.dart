import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/models/model.dart';
import '../customs/utilities/constants.dart';

class ItemObraLista extends StatelessWidget {
  const ItemObraLista({
    Key? key,
    required this.i,
    required this.onDelete,
  }) : super(key: key);

  final Funcionario i;
  final Function(Funcionario) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                onDelete(i);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Remover',
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            )
          ],
        ),
        child: Container(
          decoration: pDecoration,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i.nome,
                  style: pTitulo,
                ),
                Text(i.funcao),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
