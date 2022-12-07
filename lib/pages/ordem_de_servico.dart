import 'package:flutter/material.dart';

class OrdemDeServico extends StatefulWidget {
  const OrdemDeServico({super.key, required this.item});
  final Map item;

  @override
  State<OrdemDeServico> createState() => _OrdemDeServicoState();
}

class _OrdemDeServicoState extends State<OrdemDeServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova O.S.'),
        centerTitle: true,
      ),
    );
  }
}
