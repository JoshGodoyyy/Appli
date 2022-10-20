import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/data.dart';
import 'package:flutter/material.dart';

import '../customs/utilities/constants.dart';

class Obra extends StatefulWidget {
  const Obra({super.key, required this.local});

  final Local local;

  @override
  State<Obra> createState() => _ObraState();
}

class _ObraState extends State<Obra> {
  TextEditingController enderecoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    enderecoController.text = widget.local.endereco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.local.titulo),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.deepPurple,
        child: const Icon(Icons.save),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Center(
            child: Text(
              'Cadastrar nova obra',
              style: pTitulo,
            ),
          ),
          const SizedBox(height: 8.0),
          buildTextField(enderecoController, 'Endereço', Icons.pin_drop),
        ],
      ),
    );
  }

  Container buildTextField(controller, String hint, IconData icon) {
    return Container(
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
    );
  }
}
