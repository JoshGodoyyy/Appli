import 'package:appli/customs/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class DadosObra extends StatefulWidget {
  const DadosObra({super.key});

  @override
  State<DadosObra> createState() => _DadosObraState();
}

class _DadosObraState extends State<DadosObra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
