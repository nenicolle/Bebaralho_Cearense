// lib/features/sorteador/controller/sorteador_provider.dart
import 'package:flutter/material.dart';
import 'sorteador_controller.dart';

class SorteadorProvider extends ChangeNotifier {
  final SorteadorController _controller = SorteadorController();

  SorteadorController get controller => _controller;

  void updateSelectedCards(List<String> chosenCards) {
    _controller.updateSelectedCards(chosenCards);
    notifyListeners();
  }
}
