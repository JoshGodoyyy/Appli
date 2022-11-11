import 'package:appli/customs/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WidgetFerramenta extends StatefulWidget {
  const WidgetFerramenta({
    super.key,
    required this.ferramenta,
    required this.onTap,
  });

  final Map ferramenta;
  final Function(Map) onTap;

  @override
  State<WidgetFerramenta> createState() => _WidgetFerramentaState();
}

class _WidgetFerramentaState extends State<WidgetFerramenta> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('ferramentas');

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
                        content: const Text(
                            'Tem certeza que deseja apagar este item?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              databaseReference
                                  .child(widget.ferramenta['key'])
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
              foregroundColor: Colors.white,
              icon: Icons.delete_rounded,
              label: 'Remover',
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ],
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 7,
          child: InkWell(
            onTap: () => widget.onTap(widget.ferramenta),
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
                        widget.ferramenta['ferramenta'],
                        style: pTitulo,
                      ),
                      Text(widget.ferramenta['detalhes']),
                    ],
                  ),
                  Text(widget.ferramenta['quantidade']),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
