import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/customs/utilities/constants_menu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

  static const List<String> menuItem = [
    ConstantsMenu.editar,
    ConstantsMenu.remover
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: pContainer(
        Padding(
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
              const Spacer(),
              Text('x${widget.ferramenta['quantidade']}'),
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case ConstantsMenu.editar:
                      widget.onTap(widget.ferramenta);
                      break;
                    case ConstantsMenu.remover:
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
                        },
                      );
                      break;
                  }
                },
                itemBuilder: (context) {
                  return menuItem.map(
                    (e) {
                      return PopupMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    },
                  ).toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
