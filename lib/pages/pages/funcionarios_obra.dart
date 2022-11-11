import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';

class FuncionariosObra extends StatefulWidget {
  const FuncionariosObra({super.key});

  @override
  State<FuncionariosObra> createState() => _FuncionariosObraState();
}

class _FuncionariosObraState extends State<FuncionariosObra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
