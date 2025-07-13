class Jogador {
  final String nome;
  final String avatar;

  Jogador({required this.nome, required this.avatar});

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'avatar': avatar,
      };

  factory Jogador.fromJson(Map<String, dynamic> json) {
    return Jogador(
      nome: json['nome'],
      avatar: json['avatar'],
    );
  }
}
