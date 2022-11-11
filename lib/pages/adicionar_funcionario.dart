import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/model.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdicionarFuncionario extends StatefulWidget {
  const AdicionarFuncionario({super.key});

  @override
  State<AdicionarFuncionario> createState() => _AdicionarFuncionarioState();
}

class _AdicionarFuncionarioState extends State<AdicionarFuncionario> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Query data = FirebaseDatabase.instance.ref().child('funcionarios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        centerTitle: true,
        backgroundColor: CustomColors.lightOrange,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: data,
              itemBuilder: (context, snapshot, animation, index) {
                Map funcionario = snapshot.value as Map;
                funcionario['key'] = snapshot.key;
                return ItemFuncionario(funcionario: funcionario);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ItemFuncionario extends StatefulWidget {
  const ItemFuncionario({Key? key, required this.funcionario})
      : super(key: key);

  final Map funcionario;

  @override
  State<ItemFuncionario> createState() => _ItemFuncionarioState();
}

class _ItemFuncionarioState extends State<ItemFuncionario> {
  bool selecionado = false;

  late Funcionario funcionario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: pDecoration,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: selecionado,
                onChanged: (value) {
                  setState(() {
                    selecionado = value!;
                    if (selecionado == true) {
                      funcionario = Funcionario(
                        nome: widget.funcionario['nome'],
                        funcao: widget.funcionario['funcao'],
                      );
                      Model.instance.funcionarios.add(funcionario);
                    } else {
                      Model.instance.funcionarios.remove(funcionario);
                    }
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.funcionario['nome'],
                    style: pTitulo,
                  ),
                  Text('Função: ${widget.funcionario['funcao']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
