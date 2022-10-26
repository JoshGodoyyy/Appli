import 'package:flutter/material.dart';

import '../../../customs/utilities/constants.dart';

class ObraItem extends StatelessWidget {
  const ObraItem({Key? key, required this.nome, required this.descricao})
      : super(key: key);

  final String nome, descricao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              Text(descricao),
            ],
          ),
        ),
      ),
    );
  }
}
