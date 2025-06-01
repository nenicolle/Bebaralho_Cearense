// lib/features/sorteador/controller/sorteador_controller.dart
class SorteadorController {
  final List<String> cartas = List.generate(82, (i) => 'assets/${i + 1}.jpg');
  late List<String> cartasEmbaralhadas;
  int cartaAtualIndex = 0;
  List<String> selectedCards = [];

  SorteadorController() {
    selectedCards = List.from(cartas); // Initialize with all cards
    embaralharCartas();
  }

  List<String> getAllCards() {
    return List.from(cartas);
  }

  void updateSelectedCards(List<String> chosenCards) {
    selectedCards = List.from(chosenCards);
    if (selectedCards.isEmpty) {
      selectedCards = List.from(
        cartas,
      ); // Fallback to all cards if none selected
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

  String get cartaAtual => cartasEmbaralhadas[cartaAtualIndex];
}
