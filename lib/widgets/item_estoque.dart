import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.itemEstoque,
    required this.onDelete,
  }) : super(key: key);

  final Map itemEstoque;
  final Function(Map) onDelete;

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
                onDelete(itemEstoque['']);
              },
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              label: 'Remover',
              icon: Icons.delete_rounded,
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
                      itemEstoque['item'],
                      style: pTitulo,
                    ),
                    Text(itemEstoque['detalhes']),
                  ],
                ),
                Center(
                  child: Text(itemEstoque['quantidade']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
