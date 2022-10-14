import 'package:appli/customs/enums/tipos.dart';
import 'package:appli/customs/utilities/constants.dart';
import 'package:flutter/material.dart';

class Local extends StatelessWidget {
  const Local(
      {super.key,
      required this.titulo,
      required this.endereco,
      required this.tipo});
  final String titulo, endereco;
  final Tipos tipo;
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
            onTap: () {},
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          endereco,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
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
