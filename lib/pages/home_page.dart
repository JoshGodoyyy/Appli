import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/models/locais.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/pages/equipamentos.dart';
import 'package:appli/pages/estoque.dart';
import 'package:appli/pages/ferramentas.dart';
import 'package:appli/pages/funcionarios.dart';
import 'package:appli/pages/login.dart';
import 'package:appli/pages/obra.dart';
import 'package:appli/pages/sobre.dart';
import 'package:flutter/material.dart';

import '../customs/models/data.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/item_button.dart';
import '../widgets/local.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i in Locais.instance.obras) {
      WidgetLocal(local: i.local);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.deepPurple,
        elevation: 0,
        title: const Text('AppLi'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Sobre(),
                ),
              );
            },
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Olá, nome
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: CustomColors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Olá, ${Util.usuario}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 4),

          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: ListDate(),
                ),

                const SizedBox(height: 4.0),

                //Lista de ações

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: const [
                        pShadow,
                      ],
                    ),
                    child: Column(
                      children: [
                        ItemButton(
                          title: 'Ferramentas',
                          icon: Icons.hardware_rounded,
                          color: CustomColors.deepBlue,
                          onTap: () => onTap(
                            MaterialPageRoute(
                              builder: (context) => const Ferramentas(),
                            ),
                          ),
                        ),
                        ItemButton(
                          title: 'Estoque',
                          icon: Icons.inventory,
                          color: CustomColors.orange,
                          onTap: () => onTap(
                            MaterialPageRoute(
                              builder: (context) => const Estoque(),
                            ),
                          ),
                        ),
                        ItemButton(
                          title: 'Equipamentos',
                          icon: Icons.handyman_rounded,
                          color: CustomColors.pink,
                          onTap: () => onTap(
                            MaterialPageRoute(
                              builder: (context) => const Equipamentos(),
                            ),
                          ),
                        ),
                        ItemButton(
                          title: 'Funcionários',
                          icon: Icons.group,
                          color: CustomColors.deepPurple,
                          onTap: () => onTap(
                            MaterialPageRoute(
                              builder: (context) => const Funcionarios(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 4.0),

                const Center(
                  child: Text(
                    'Locais',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 4.0),

                for (var i in Locais.instance.obras)
                  WidgetLocal(local: i.local),

                TextButton(
                  onPressed: () {
                    bottomSheet(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add_circle_outline_rounded),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cadastrar Local'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    TextEditingController tituloController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();

    void clearAll() {
      tituloController.clear();
      enderecoController.clear();
    }

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      backgroundColor: const Color(0xFFe2e2e2),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Adicionar Local',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                buildTextField(
                  tituloController,
                  'Titulo',
                  Icons.text_fields_rounded,
                ),
                const SizedBox(height: 16.0),
                buildTextField(
                  enderecoController,
                  'Endereco',
                  Icons.pin_drop_rounded,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (tituloController.text == '' ||
                          enderecoController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Você precisa preencher todos os campos'),
                          ),
                        );
                        return;
                      }

                      Navigator.pop(context);

                      Local local = Local(
                        null,
                        titulo: tituloController.text,
                        endereco: enderecoController.text,
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => NovaObra(local: local),
                        ),
                      );

                      clearAll();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.deepPurple,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text('Adicionar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

  void onTap(Route route) {
    Navigator.of(context).push(route);
  }
}
