import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/customs/utilities/status.dart';
import 'package:appli/pages/ordem_de_servico.dart';
import 'package:flutter/material.dart';

class Relatorio extends StatefulWidget {
  const Relatorio({super.key, required this.item});
  final Map item;

  @override
  State<Relatorio> createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
  String valor = Status.disponivel;

  bool isVisible() => valor == Status.manutencao ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildItem(context, 'Patrimônio nº:', 'numero'),
            buildItem(context, 'Equipamento:', 'equipamento'),
            buildItem(context, 'Descrição:', 'descricao'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Status:',
                style: pTitulo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: pDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    items: Status.status.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    value: valor,
                    onChanged: (String? value) {
                      setState(
                        () {
                          valor = value!;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible(),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              OrdemDeServico(item: widget.item),
                        ),
                      )
                      .then((value) => print('a'));
                },
                child: const Center(
                  child: Text(
                    'Nova Ordem de Serviço',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.check),
      ),
    );
  }

  Padding buildItem(BuildContext context, String titulo, String item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              titulo,
              style: pTitulo,
            ),
          ),
          Container(
            decoration: pDecoration,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.item[item],
                  style: pTitulo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
