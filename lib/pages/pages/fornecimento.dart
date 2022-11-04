import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

class Fornecimento extends StatefulWidget {
  const Fornecimento({super.key});

  @override
  State<Fornecimento> createState() => _FornecimentoState();
}

class _FornecimentoState extends State<Fornecimento> {
  TextEditingController responsavelController = TextEditingController();
  TextEditingController funcionarioController = TextEditingController();

  List<String> list = [];
  String? dropDownValue;
  @override
  void initState() {
    super.initState();

    if (list.isEmpty) {
      list.add('Vazio');
      dropDownValue = list.first;
      return;
    }
    dropDownValue = list.first;
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Funcionário:'),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    decoration: pDecoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
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
                      ),
                    ),
                  ),
                ),
              ],
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
                child: const Text('Visualizar'),
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
