import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.itemEstoque,
    required this.onTap,
  }) : super(key: key);

  final Map itemEstoque;
  final Function(Map) onTap;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('epis');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                                  .child(widget.itemEstoque['key'])
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
            ),
          ],
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 7,
          child: InkWell(
            onTap: () => widget.onTap(widget.itemEstoque),
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemEstoque['item'],
                        style: pTitulo,
                      ),
                      Text(widget.itemEstoque['detalhes']),
                    ],
                  ),
                  Center(
                    child: Text(widget.itemEstoque['quantidade']),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
