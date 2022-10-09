import 'package:appli/customs/colors/custom_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/item_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.white60,
        elevation: 5,
        title: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Olá, Josh',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.person),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    listDate('Sab.', '08', 'Out.', true),
                    listDate('Dom.', '09', 'Out.', false),
                    listDate('Seg.', '10', 'Out.', false),
                    listDate('Ter.', '11', 'Out.', false),
                    listDate('Qua.', '12', 'Out.', false),
                    listDate('Qui.', '13', 'Out.', false),
                    listDate('Sex.', '14', 'Out.', false),
                    listDate('Sab.', '15', 'Out.', false),
                    listDate('Dom.', '16', 'Out.', false),
                    listDate('Seg.', '17', 'Out.', false),
                    listDate('Ter.', '18', 'Out.', false),
                    listDate('Qua.', '19', 'Out.', false),
                    listDate('Qui.', '20', 'Out.', false),
                    listDate('Sex.', '21', 'Out.', false),
                    listDate('Sab.', '22', 'Out.', false),
                    listDate('Dom.', '23', 'Out.', false),
                    listDate('Seg.', '24', 'Out.', false),
                    listDate('Ter.', '25', 'Out.', false),
                    listDate('Qua.', '26', 'Out.', false),
                    listDate('Qui.', '27', 'Out.', false),
                    listDate('Sex.', '28', 'Out.', false),
                    listDate('Sab.', '29', 'Out.', false),
                    listDate('Dom.', '30', 'Out.', false),
                    listDate('Seg.', '31', 'Out.', false),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      ItemButton(
                        title: 'Locais',
                        icon: Icons.app_registration_outlined,
                        color: CustomColors.blue,
                      ),
                      ItemButton(
                        title: 'Equipamentos',
                        icon: Icons.settings,
                        color: CustomColors.lightOrange,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ItemButton(
                        title: 'Ferramentas',
                        icon: Icons.handyman_rounded,
                        color: CustomColors.orange,
                      ),
                      ItemButton(
                        title: 'Estoque',
                        icon: Icons.inventory,
                        color: CustomColors.pink,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      ItemButton(
                        title: 'Funcionários',
                        icon: Icons.group,
                        color: CustomColors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding listDate(String day, String number, String month, bool today) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: today ? CustomColors.purple : Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Text(
                number,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                month,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
