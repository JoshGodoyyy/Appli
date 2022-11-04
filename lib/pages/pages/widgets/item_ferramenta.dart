import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../../customs/models/data.dart';

class ItemFerramenta extends StatefulWidget {
  const ItemFerramenta({
    super.key,
    required this.ferramenta,
  });

  final Ferramenta ferramenta;

  @override
  State<ItemFerramenta> createState() => _ItemFerramentaState();
}

class _ItemFerramentaState extends State<ItemFerramenta> {
  int quantidade = 1;

  bool get quantidadeMinima => quantidade == 1;
  bool get quantidadeMaxima => quantidade == widget.ferramenta.quantidade;

  void remover() => quantidade--;
  void adicionar() => quantidade++;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    widget.ferramenta.nome,
                    style: pTitulo,
                  ),
                  Text(widget.ferramenta.detalhes)
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        setState(() => quantidadeMinima ? null : remover()),
                    icon: Icon(
                      Icons.remove,
                      color: quantidadeMinima
                          ? CustomColors.purple
                          : CustomColors.deepPurple,
                    ),
                  ),
                  Text('$quantidade'),
                  IconButton(
                    onPressed: () =>
                        setState(() => quantidadeMaxima ? null : adicionar()),
                    icon: Icon(
                      Icons.add,
                      color: quantidadeMaxima
                          ? CustomColors.purple
                          : CustomColors.deepPurple,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
