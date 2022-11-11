class Model {
  static Model instance = Model();
  List<Ferramenta> ferramentas = [];
  List<Equipamento> equipamentos = [];
  List<Funcionario> funcionarios = [];
}

class Ferramenta {
  String ferramenta, detalhes;
  int quantidade;
  Ferramenta(
    this.quantidade, {
    required this.ferramenta,
    required this.detalhes,
  });

  Map<String, dynamic> toJson() {
    return {
      'ferramenta': ferramenta,
      'detalhes': detalhes,
      'quantidade': quantidade,
    };
  }
}

class Equipamento {
  String equipamento, detalhes;
  int numero;

  Equipamento({
    required this.equipamento,
    required this.numero,
    required this.detalhes,
  });

  Map<String, dynamic> toJeysson() {
    return {
      'equipamento': equipamento,
      'numero': numero,
      'detalhes': detalhes,
    };
  }
}

class Funcionario {
  String nome, funcao;

  Funcionario({
    required this.nome,
    required this.funcao,
  });

  Map<String, dynamic> toJson() {
    return {
      'funcionario': nome,
      'funcao': funcao,
    };
  }
}
