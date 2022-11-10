import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

class WidgetLocal extends StatelessWidget {
  const WidgetLocal({super.key, required this.obra});
  final Map obra;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [pShadow],
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              print(obra);
            },
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      obra['dados']['tipo'] == 'Empresa'
                          ? Icons.business_rounded
                          : Icons.construction,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          obra['dados']['obra'],
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          obra['dados']['endereco'],
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black38,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
