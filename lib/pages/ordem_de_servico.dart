import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

class OrdemDeServico extends StatefulWidget {
  const OrdemDeServico({super.key, required this.item});
  final Map item;

  @override
  State<OrdemDeServico> createState() => _OrdemDeServicoState();
}

class _OrdemDeServicoState extends State<OrdemDeServico> {
  final OutlineInputBorder none =
      const OutlineInputBorder(borderSide: BorderSide.none);

  bool corretiva = false;
  bool preditiva = false;
  bool preventiva = false;

  bool estaParada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova O.S.'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              singleText('Nº Ordem de Serviço:'),
              singleText('Descrição do equipamento:'),
              singleText('Motivo:'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tipo:', style: pTitulo),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                corretiva = !corretiva;
                                preditiva = false;
                                preventiva = false;
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  corretiva ? Colors.blueAccent : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Corretiva',
                                style: TextStyle(
                                  color:
                                      corretiva ? Colors.white : Colors.black54,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                corretiva = false;
                                preditiva = !preditiva;
                                preventiva = false;
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  preditiva ? Colors.blueAccent : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Preditiva',
                                style: TextStyle(
                                  color:
                                      preditiva ? Colors.white : Colors.black54,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                corretiva = false;
                                preditiva = false;
                                preventiva = !preventiva;
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  preventiva ? Colors.blueAccent : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Preventiva',
                                style: TextStyle(
                                  color: preventiva
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Equipamento parado:',
                      style: pTitulo,
                    ),
                    Row(
                      children: [
                        Switch(
                          value: estaParada,
                          onChanged: ((value) =>
                              setState(() => estaParada = value)),
                        ),
                        Text(estaParada ? 'Sim' : 'Não', style: pTitulo),
                      ],
                    )
                  ],
                ),
              ),
              richText('Descrição do serviço:'),
              singleText('Data de início:'),
              singleText('Data de término:'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Peças utilizadas:',
                  style: pTitulo,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0)),
                  child: const Text('Adicionar peça'),
                ),
              ),
              singleText('Responsável:'),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0)),
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column richText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: pTitulo,
          ),
        ),
        pContainer(
          TextField(
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
              border: none,
              errorBorder: none,
              enabledBorder: none,
            ),
          ),
        ),
      ],
    );
  }

  Column singleText(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: pTitulo,
          ),
        ),
        pContainer(
          TextField(
            decoration: InputDecoration(
              border: none,
              errorBorder: none,
              enabledBorder: none,
            ),
          ),
        ),
      ],
    );
  }
}
