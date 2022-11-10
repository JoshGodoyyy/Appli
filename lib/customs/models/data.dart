import 'package:appli/customs/enums/tipos.dart';

class Util {
  static String? usuario;
  static String? status;
}

class Local {
  String titulo, endereco;
  Tipos? tipo;
  Local(
    this.tipo, {
    required this.titulo,
    required this.endereco,
  });
}
