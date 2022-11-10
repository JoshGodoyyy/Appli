import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/model.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AdicionarFerramenta extends StatefulWidget {
  const AdicionarFerramenta({super.key});

  @override
  State<AdicionarFerramenta> createState() => _AdicionarFerramentaState();
}

class _AdicionarFerramentaState extends State<AdicionarFerramenta> {
  @override
  Widget build(BuildContext context) {
    Query data = FirebaseDatabase.instance.ref().child('ferramentas');

    getData() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas'),
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
              itemBuilder: (
                context,
                snapshot,
                animation,
                index,
              ) {
                Map item = snapshot.value as Map;
                item['key'] = snapshot.key;
                return ItemFerramenta(item: item);
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

class ItemFerramenta extends StatelessWidget {
  const ItemFerramenta({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Ferramenta ferramenta = Ferramenta(
              int.parse(item['quantidade']),
              ferramenta: item['ferramenta'],
              detalhes: item['detalhes'],
            );
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              context: context,
              builder: (context) {
                return Adicionar(ferramenta: ferramenta);
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['ferramenta'],
                  style: pTitulo,
                ),
                Text(item['detalhes']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Adicionar extends StatefulWidget {
  const Adicionar({
    super.key,
    required this.ferramenta,
  });
  final Ferramenta ferramenta;

  @override
  State<Adicionar> createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {
  int quantidade = 1;

  bool get valorMinimo => quantidade == 1;
  bool get valorMaximo => quantidade == widget.ferramenta.quantidade;

  void remover() => quantidade--;
  void adicionar() => quantidade++;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        const Center(
          child: Text(
            'Item selecionado',
            style: pTitulo,
          ),
        ),
        buildItem(context, widget.ferramenta.ferramenta),
        buildItem(context, 'Detalhes: ${widget.ferramenta.detalhes}'),
        buildItem(context, 'Em estoque: ${widget.ferramenta.quantidade}'),
        const Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0),
          child: Text('Selecionar quantidade:', style: pTitulo),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: pDecoration,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => valorMinimo
                      ? null
                      : setState(
                          () => remover(),
                        ),
                  icon: const Icon(Icons.remove),
                ),
                const Spacer(),
                Text('$quantidade'),
                const Spacer(),
                IconButton(
                  onPressed: () => valorMaximo
                      ? null
                      : setState(
                          () => adicionar(),
                        ),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Ferramenta ferramenta = Ferramenta(
                  quantidade,
                  ferramenta: widget.ferramenta.ferramenta,
                  detalhes: widget.ferramenta.detalhes,
                );

                Model.instance.ferramentas.add(ferramenta);
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
              child: const Text('Adicionar'),
            ),
          ),
        ),
        const Spacer()
      ],
    );
  }

  Padding buildItem(BuildContext context, String texto) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        right: 8.0,
        left: 8.0,
      ),
      child: Container(
        decoration: pDecoration,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            texto,
            style: pTitulo,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
