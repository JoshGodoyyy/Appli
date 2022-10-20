import 'package:appli/customs/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class WidgetFuncionario extends StatelessWidget {
  const WidgetFuncionario({
    super.key,
    required this.funcionario,
    required this.onDelete,
  });

  final Funcionario funcionario;
  final Function(Funcionario) onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(funcionario),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Remover',
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
                  funcionario.nome,
                  style: pTitulo,
                ),
                Text(funcionario.funcao),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
