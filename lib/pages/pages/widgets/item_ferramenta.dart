import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/data.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/pages/pages/adicionar_ferramenta.dart';
import 'package:flutter/material.dart';

class ItemFerramenta extends StatefulWidget {
  const ItemFerramenta({
    super.key,
    required this.ferramentas,
  });

  final List<Ferramenta> ferramentas;
  @override
  State<ItemFerramenta> createState() => _ItemFerramentaState();
}

class _ItemFerramentaState extends State<ItemFerramenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var i in ferramentas) Item(ferramenta: i),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.ferramenta,
  }) : super(key: key);

  final Ferramenta ferramenta;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int quantidade = 1;

  bool get quantidadeMinima => quantidade == 1;
  bool get quantidadeMaxima => quantidade == widget.ferramenta.quantidade;

  void decrement() => quantidade--;
  void increment() => quantidade++;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: pDecoration,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.ferramenta.nome,
                style: pTitulo,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => quantidadeMinima ? null : decrement());
                    },
                    icon: Icon(
                      Icons.remove,
                      color: quantidadeMinima
                          ? CustomColors.lightBlue
                          : CustomColors.deepBlue,
                    ),
                  ),
                  Text('$quantidade'),
                  IconButton(
                    onPressed: () {
                      setState(() => quantidadeMaxima ? null : increment());
                    },
                    icon: Icon(
                      Icons.add,
                      color: quantidadeMaxima
                          ? CustomColors.lightBlue
                          : CustomColors.deepBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
