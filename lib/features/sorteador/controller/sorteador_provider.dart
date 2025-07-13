import 'package:flutter/foundation.dart';
import 'package:bebaralho/features/sorteador/controller/sorteador_controller.dart';

class SorteadorProvider extends ChangeNotifier {
  final SorteadorController controller;

  SorteadorProvider() : controller = SorteadorController();

  void updateSelectedCards(List<String> chosenCards) {
    controller.updateSelectedCards(chosenCards);
    notifyListeners();
  }

  void trocarBaralho(String novoBaralho) {
    controller.trocarBaralho(novoBaralho);
    notifyListeners();
  }

  String get cartaAtual => controller.cartaAtual;

  void proximaCarta() {
    controller.proximaCarta();
    notifyListeners();
  }

  void voltarCarta() {
    controller.voltarCarta();
    notifyListeners();
  }
}
