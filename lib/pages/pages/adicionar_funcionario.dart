import 'package:appli/customs/models/data.dart';
import 'package:flutter/material.dart';

import '../../customs/models/locais.dart';
import '../../customs/models/nova_obra.dart';
import '../../customs/utilities/constants.dart';

class AdicionarFuncionario extends StatelessWidget {
  const AdicionarFuncionario({super.key});

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
          'Selecionar funcionários',
          style: pTitulo,
        ),
        for (var i in Locais.instance.funcionarios) Item(funcionario: i),
      ],
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    Key? key,
    required this.funcionario,
  }) : super(key: key);

  final Funcionario funcionario;

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
                        CadastrarNovaObra.instance.funcionarios
                            .remove(widget.funcionario);
                      } else {
                        CadastrarNovaObra.instance.funcionarios
                            .add(widget.funcionario);
                      }
                    },
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.funcionario.nome),
                  Text(widget.funcionario.funcao),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
