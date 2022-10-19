import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

class Fornecimento extends StatefulWidget {
  const Fornecimento({super.key});

  @override
  State<Fornecimento> createState() => _FornecimentoState();
}

const List<String> list = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

class _FornecimentoState extends State<Fornecimento> {
  TextEditingController responsavelController = TextEditingController();
  TextEditingController funcionarioController = TextEditingController();

  String dropDownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          buildText(
            responsavelController,
            'Responsável',
            Icons.person,
          ),
          Row(
            children: [
              Expanded(
                child: buildText(
                  funcionarioController,
                  'Pesquisar',
                  Icons.search,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(18.0),
                    backgroundColor: CustomColors.orange,
                  ),
                  child: const Icon(Icons.send_sharp),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: pDecoration,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: dropDownValue,
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: CustomColors.orange,
                ),
                child: const Text('Finalizar'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildText(controller, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: pDecoration,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
