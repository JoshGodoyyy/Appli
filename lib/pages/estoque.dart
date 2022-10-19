import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/themes/theme_constants.dart';
import 'package:appli/pages/pages/fornecimento.dart';
import 'package:appli/pages/pages/itens.dart';
import 'package:flutter/material.dart';

class Estoque extends StatefulWidget {
  const Estoque({super.key});

  @override
  State<Estoque> createState() => _EstoqueState();
}

class _EstoqueState extends State<Estoque> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Itens',
                ),
                Tab(text: 'Fornecimento')
              ],
            ),
            title: const Text('Estoque'),
            backgroundColor: CustomColors.orange,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: const TabBarView(
            children: [
              Itens(),
              Fornecimento(),
            ],
          ),
        ),
      ),
    );
  }
}
