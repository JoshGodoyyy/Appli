import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../customs/utilities/constants.dart';

class WidgetFuncionario extends StatefulWidget {
  const WidgetFuncionario({
    super.key,
    required this.funcionario,
    required this.onTap,
  });

  final Map funcionario;
  final Function(Map) onTap;

  @override
  State<WidgetFuncionario> createState() => _WidgetFuncionarioState();
}

class _WidgetFuncionarioState extends State<WidgetFuncionario> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('funcionarios');
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Atenção'),
                      content: const Text('Tem certeza que deseja apagar?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            databaseReference
                                .child(widget.funcionario['key'])
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
                  },
                );
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 7,
          child: InkWell(
            onTap: () => widget.onTap(widget.funcionario),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.funcionario['nome'],
                      style: pTitulo,
                    ),
                    Text(widget.funcionario['funcao']),
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
