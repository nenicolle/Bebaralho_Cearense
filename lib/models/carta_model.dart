class CartaModel {
  final int id;
  final String nome;
  final String efeito;
  final String tipo;
  final String imagem;
  final CartaFlags flags;

  CartaModel({
    required this.id,
    required this.nome,
    required this.efeito,
    required this.tipo,
    required this.imagem,
    required this.flags,
  });

  factory CartaModel.fromJson(Map<String, dynamic> json) {
    return CartaModel(
      id: json['id'],
      nome: json['nome'],
      efeito: json['efeito'],
      tipo: json['tipo'],
      imagem: json['imagem'],
      flags: CartaFlags.fromJson(json['flags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'efeito': efeito,
      'tipo': tipo,
      'imagem': imagem,
      'flags': flags.toJson(),
    };
  }
}

class CartaFlags {
  final bool requerEscolhaDeJogador;
  final bool interrompeOrdem;
  final int? rodadas;

  CartaFlags({
    required this.requerEscolhaDeJogador,
    required this.interrompeOrdem,
    this.rodadas,
  });

  factory CartaFlags.fromJson(Map<String, dynamic> json) {
    return CartaFlags(
      requerEscolhaDeJogador: json['requerEscolhaDeJogador'],
      interrompeOrdem: json['interrompeOrdem'],
      rodadas: json['rodadas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requerEscolhaDeJogador': requerEscolhaDeJogador,
      'interrompeOrdem': interrompeOrdem,
      'rodadas': rodadas,
    };
  }
}
