import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.nome,
    required this.funcao,
  });

  final String nome;
  final String funcao;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Remover',
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
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
                Text(
                  nome,
                  style: pTitulo,
                ),
                Text(funcao),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
