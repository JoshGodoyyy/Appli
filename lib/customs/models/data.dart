import 'package:appli/customs/enums/tipos.dart';

class Util {
  static String? usuario;
  static String? status;
}

class Obra {
  Local local;
  List<Ferramenta> ferramentas;
  List<Equipamento> equipamentos;
  List<Map> funcionarios;

  Obra({
    required this.local,
    required this.ferramentas,
    required this.equipamentos,
    required this.funcionarios,
  });
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

class Ferramenta {
  String nome, detalhes;
  int quantidade;

  Ferramenta({
    required this.nome,
    required this.detalhes,
    required this.quantidade,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'detalhes': detalhes,
      'quantidade': quantidade,
    };
  }
}

class Equipamento {
  String nome, descricao;
  int numero;

  Equipamento({
    required this.nome,
    required this.descricao,
    required this.numero,
  });
}
