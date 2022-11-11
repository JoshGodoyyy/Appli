import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';

class EquipamentosObra extends StatefulWidget {
  const EquipamentosObra({super.key});

  @override
  State<EquipamentosObra> createState() => _EquipamentosObraState();
}

class _EquipamentosObraState extends State<EquipamentosObra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipamentos da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
