class SorteadorController {
  final List<String> cartas = List.generate(82, (i) => 'assets/${i + 1}.jpg');
  late List<String> cartasEmbaralhadas;
  int cartaAtualIndex = 0;

  void embaralharCartas() {
    cartasEmbaralhadas = List.from(cartas)..shuffle();
    cartaAtualIndex = 0;
  }

  void proximaCarta() {
    cartaAtualIndex++;
    if (cartaAtualIndex >= cartasEmbaralhadas.length) embaralharCartas();
  }

  String get cartaAtual => cartasEmbaralhadas[cartaAtualIndex];
}
