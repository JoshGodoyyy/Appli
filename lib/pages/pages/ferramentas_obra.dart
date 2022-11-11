import 'package:flutter/material.dart';

import '../../customs/colors/custom_colors.dart';

class FerramentasObra extends StatefulWidget {
  const FerramentasObra({super.key});

  @override
  State<FerramentasObra> createState() => _FerramentasObraState();
}

class _FerramentasObraState extends State<FerramentasObra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas da Obra'),
        centerTitle: true,
        backgroundColor: CustomColors.deepPurple,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
