import 'package:appli/customs/models/data.dart';
import 'package:appli/customs/models/nova_obra.dart';
import 'package:flutter/material.dart';

import '../../customs/models/locais.dart';
import '../../customs/utilities/constants.dart';

class AdicionarEquipamento extends StatefulWidget {
  const AdicionarEquipamento({super.key});

  @override
  State<AdicionarEquipamento> createState() => _AdicionarEquipamentoState();
}

class _AdicionarEquipamentoState extends State<AdicionarEquipamento> {
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
          'Selecionar equipamento',
          style: pTitulo,
        ),
        for (var i in Locais.instance.equipamentos) Item(equipamento: i),
      ],
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.equipamento,
  }) : super(key: key);

  final Equipamento equipamento;

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
                        CadastrarNovaObra.instance.equipamentos
                            .remove(widget.equipamento);
                      } else {
                        CadastrarNovaObra.instance.equipamentos
                            .add(widget.equipamento);
                      }
                    },
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.equipamento.nome),
                  Text(widget.equipamento.descricao),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
