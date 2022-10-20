import 'package:appli/customs/enums/tipos.dart';

class Local {
  String titulo, endereco;
  Tipos tipo;
  Local({required this.titulo, required this.endereco, required this.tipo});
}

class Ferramenta {
  String nome, detalhes;
  int quantidade;

  Ferramenta({
    required this.nome,
    required this.detalhes,
    required this.quantidade,
  });
}

class ItemEstoque {
  String item;
  String detalhes;
  int quantidade;

  ItemEstoque({
    required this.item,
    required this.detalhes,
    required this.quantidade,
  });
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

class Funcionario {
  String nome, funcao;

  Funcionario({
    required this.nome,
    required this.funcao,
  });
}
