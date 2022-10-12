import 'package:appli/customs/enums/tipos.dart';
import 'package:flutter/material.dart';

import '../customs/colors/custom_colors.dart';

class Local extends StatelessWidget {
  const Local(
      {super.key,
      required this.titulo,
      required this.endereco,
      required this.tipo});
  final String titulo, endereco;
  final Tipos tipo;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                width: 5.0,
                color: tipo == Tipos.empresa
                    ? CustomColors.deepBlue
                    : CustomColors.orange,
                height: 76.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      endereco,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
