class SorteadorController {
  final Map<String, int> baralhos = {
    'bebaralho-cearense': 97,
    'hipoteticamente': 80,
    'bebaralho-br': 77,
  };

  late List<String> cartas;
  late List<String> cartasEmbaralhadas;
  int cartaAtualIndex = 0;
  List<String> selectedCards = [];
  String baralhoAtual = 'bebaralho-cearense';

  SorteadorController() {
    _loadCartas(baralhoAtual);
    selectedCards = List.from(cartas);
    embaralharCartas();
  }

  void _loadCartas(String baralho) {
    final int numCartas = baralhos[baralho] ?? 50;
    if (baralho == 'bebaralho-cearense') {
      cartas = List.generate(numCartas, (i) => 'assets/$baralho/${i + 1}.jpg');
    } else if (baralho == 'bebaralho-br') {
      cartas = List.generate(numCartas, (i) => 'assets/$baralho/${i + 1}.png');
    } else {
      cartas = List.generate(numCartas, (i) => 'assets/$baralho/${i + 1}.png');
    }
    print('Cartas carregadas para $baralho: $cartas');
  }

  List<String> getAllCards() {
    return List.from(cartas);
  }

  void trocarBaralho(String novoBaralho) {
    if (baralhos.containsKey(novoBaralho)) {
      baralhoAtual = novoBaralho;
      _loadCartas(novoBaralho);
      updateSelectedCards(List.from(cartas));
    }
  }

  void updateSelectedCards(List<String> chosenCards) {
    selectedCards = List.from(chosenCards);
    if (selectedCards.isEmpty) {
      selectedCards = List.from(cartas);
    }
    embaralharCartas();
  }

  void embaralharCartas() {
    cartasEmbaralhadas = List.from(selectedCards)..shuffle();
    cartaAtualIndex = 0;
  }

  void proximaCarta() {
    cartaAtualIndex++;
    if (cartaAtualIndex >= cartasEmbaralhadas.length) {
      embaralharCartas();
    }
  }

  void voltarCarta() {
    if (cartaAtualIndex > 0) {
      cartaAtualIndex--;
    }
  }

  String get cartaAtual => cartasEmbaralhadas.isNotEmpty
      ? cartasEmbaralhadas[cartaAtualIndex]
      : 'assets/$baralhoAtual/1.png'; // Fallback para evitar erros
}
