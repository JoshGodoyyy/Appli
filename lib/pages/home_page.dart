import 'dart:async';
import 'dart:developer' as developer;
import 'package:appli/pages/login.dart';
import 'package:appli/pages/obras.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:appli/pages/equipamentos.dart';
import 'package:appli/pages/estoque.dart';
import 'package:appli/pages/ferramentas.dart';
import 'package:appli/pages/funcionarios.dart';
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
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
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
          //Botão logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          //Botao ajuda
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
      body: SingleChildScrollView(
        child: Column(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Olá, ${Util.usuario}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8.0),
            //Calendario
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: ListDate(),
            ),

            const SizedBox(height: 4.0),

            //Lista de ações
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
                    //Ferra,emtas
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
                    //Estoque
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
                    //Equipamentos
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
                    //Funcionários
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
                    //Obras
                    ItemButton(
                      title: 'Obras',
                      icon: Icons.business_center,
                      color: CustomColors.deepBlue,
                      onTap: () => onTap(
                        MaterialPageRoute(
                          builder: (context) => const TodasAsObras(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              ),
              child: const Text('Login'),
            ),

            //Check conexão
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
      ),
    );
  }

  void onTap(Route route) {
    Navigator.of(context).push(route);
  }
}
