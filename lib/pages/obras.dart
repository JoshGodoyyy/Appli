import 'package:appli/customs/colors/custom_colors.dart';
import 'package:appli/firebase_options.dart';
import 'package:appli/pages/obra.dart';
import 'package:appli/widgets/local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class TodasAsObras extends StatefulWidget {
  const TodasAsObras({super.key});

  @override
  State<TodasAsObras> createState() => _TodasAsObrasState();
}

class _TodasAsObrasState extends State<TodasAsObras> {
  getData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obras em Andamento'),
        centerTitle: true,
        backgroundColor: CustomColors.deepBlue,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CustomColors.deepBlue,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NovaObra(),
          ),
        ),
        label: const Text('Nova Obra'),
        icon: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAnimatedList(
              query: FirebaseDatabase.instance.ref().child('obras'),
              itemBuilder: (context, snapshot, animation, index) {
                Map obra = snapshot.value as Map;
                obra['key'] = snapshot.key;
                return WidgetLocal(obra: obra);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
