import 'package:appli/customs/models/data.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WidgetFerramenta extends StatelessWidget {
  const WidgetFerramenta({
    super.key,
    required this.ferramenta,
    required this.onDelete,
  });

  final Ferramenta ferramenta;
  final Function(Ferramenta) onDelete;

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
                onDelete(ferramenta);
              },
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ferramenta.nome,
                      style: pTitulo,
                    ),
                    Text(ferramenta.detalhes),
                  ],
                ),
                Text('${ferramenta.quantidade}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
