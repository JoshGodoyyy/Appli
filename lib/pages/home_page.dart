import 'dart:async';
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/pages/equipamentos.dart';
import 'package:appli/pages/estoque.dart';
import 'package:appli/pages/ferramentas.dart';
import 'package:appli/pages/funcionarios.dart';
import 'package:appli/pages/obra.dart';
import 'package:appli/pages/sobre.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../customs/models/data.dart';
import '../widgets/horizontal_calendar.dart';
import '../widgets/item_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void clearAll() {
    tituloController.clear();
    enderecoController.clear();
  }

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() => _connectionStatus = result);
  }

  String conexao() {
    switch (_connectionStatus) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        Util.status = 'Conectado';
        break;
      case ConnectivityResult.none:
        Util.status = 'Desconectado';
        break;
      default:
        Util.status = _connectionStatus.toString();
        break;
    }
    return Util.status!;
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
            onPressed: () => FirebaseAuth.instance.signOut(),
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

          const SizedBox(height: 8.0),

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

                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Você precisa preencher todos os campos'),
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
                                      Navigator.of(context)
                                          .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NovaObra(local: local),
                                            ),
                                          )
                                          .then(
                                            (_) => setState(
                                              () {},
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

          Visibility(
            visible: conexao() == 'Conectado' ? false : true,
            child: Container(
              color: conexao() != 'Conectado' ? Colors.red : null,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  conexao(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
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
