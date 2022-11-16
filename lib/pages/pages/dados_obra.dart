import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../customs/enums/tipos.dart';

class DadosObra extends StatefulWidget {
  const DadosObra({super.key, required this.obra});
  final Map obra;

  @override
  State<DadosObra> createState() => _DadosObraState();
}

class _DadosObraState extends State<DadosObra> {
  TextEditingController obraController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  Tipos? tipo;

  DateTime? inicio, fim;
  String dataInicial = '';
  String dataFinal = '';
  String? prazo;

  @override
  void initState() {
    obraController.text = widget.obra['dados']['obra'];
    enderecoController.text = widget.obra['dados']['endereco'];
    dataInicial = widget.obra['dados']['previsaoEntrega'];
    dataFinal = widget.obra['dados']['previsaoEntrega'];
    if (widget.obra['dados']['tipo'] == 'Empresa') {
      tipo = Tipos.empresa;
    } else {
      tipo = Tipos.obra;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          buildTextField(context, 'Obra:', obraController),
          buildTextField(context, 'Endereço:', enderecoController),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Tipo:',
                  style: pTitulo,
                ),
                Row(
                  children: [
                    Radio<Tipos>(
                      value: Tipos.empresa,
                      groupValue: tipo,
                      activeColor: CustomColors.deepPurple,
                      onChanged: (Tipos? value) => setState(() => tipo = value),
                    ),
                    const Text('Empresa'),
                  ],
                ),
                Row(
                  children: [
                    Radio<Tipos>(
                      value: Tipos.obra,
                      groupValue: tipo,
                      activeColor: CustomColors.deepPurple,
                      onChanged: (Tipos? value) => setState(() => tipo = value),
                    ),
                    const Text('Obra'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Início da obra:',
                    style: pTitulo,
                  ),
                ),
                Container(
                  decoration: pDecoration,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      dataInicial.toString(),
                      style: pTitulo,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Final da obra:',
                    style: pTitulo,
                  ),
                ),
                Container(
                  decoration: pDecoration,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      dataInicial.toString(),
                      style: pTitulo,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Prazo da obra:',
                    style: pTitulo,
                  ),
                ),
                Container(
                  decoration: pDecoration,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'prazo',
                      style: pTitulo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTextField(
      BuildContext context, String titulo, TextEditingController controller) {
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
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: controller,
              style: pTitulo,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
