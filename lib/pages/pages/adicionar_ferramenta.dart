import 'package:appli/customs/models/locais.dart';
import 'package:appli/customs/models/nova_obra.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../customs/models/data.dart';

class AdicionarFerramenta extends StatefulWidget {
  const AdicionarFerramenta({super.key});

  @override
  State<AdicionarFerramenta> createState() => _AdicionarFerramentaState();
}

final List<Ferramenta> ferramentas = [];

class _AdicionarFerramentaState extends State<AdicionarFerramenta> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
      children: const [
        AdicionarItem(),
      ],
    );
  }
}

class AdicionarItem extends StatelessWidget {
  const AdicionarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Selecionar ferramentas',
          style: pTitulo,
        ),
        for (var i in Locais.instance.ferramentas) Item(ferramenta: i),
      ],
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
  bool state = false;
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
            children: [
              Checkbox(
                value: state,
                onChanged: (value) {
                  setState(
                    () {
                      state = value!;
                      if (state == false) {
                        CadastrarNovaObra.instance.ferramentas
                            .remove(widget.ferramenta);
                      } else {
                        CadastrarNovaObra.instance.ferramentas
                            .add(widget.ferramenta);
                      }
                    },
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.ferramenta.nome),
                  Text(widget.ferramenta.detalhes),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
