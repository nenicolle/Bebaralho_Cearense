import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/carta_model.dart';

class CartaProvider extends ChangeNotifier {
  Map<String, List<CartaModel>> _todosBaralhos = {};
  String _baralhoAtual = '';
  Set<int> _cartasExcluidas = {}; // IDs das cartas excluídas do sorteio

  Map<String, List<CartaModel>> get todosBaralhos => _todosBaralhos;
  String get baralhoAtual => _baralhoAtual;
  Set<int> get cartasExcluidas => _cartasExcluidas;

  // Cartas disponíveis para sorteio (não excluídas)
  List<CartaModel> get cartasDisponiveis {
    if (_baralhoAtual.isEmpty || !_todosBaralhos.containsKey(_baralhoAtual)) {
      return [];
    }
    return _todosBaralhos[_baralhoAtual]!
        .where((carta) => !_cartasExcluidas.contains(carta.id))
        .toList();
  }

  // Todas as cartas do baralho atual
  List<CartaModel> get todasCartasBaralhoAtual {
    if (_baralhoAtual.isEmpty || !_todosBaralhos.containsKey(_baralhoAtual)) {
      return [];
    }
    return _todosBaralhos[_baralhoAtual]!;
  }

  // Carrega as cartas do JSON
  Future<void> carregarCartas() async {
    try {
      final String response = await rootBundle.loadString('assets/cartas.json');
      final Map<String, dynamic> data = json.decode(response);

      _todosBaralhos.clear();
      data.forEach((baralho, cartas) {
        _todosBaralhos[baralho] = (cartas as List)
            .map((carta) => CartaModel.fromJson(carta))
            .toList();
      });

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar cartas: $e');
    }
  }

  // Define o baralho atual
  void definirBaralhoAtual(String nomeBaralho) {
    if (_todosBaralhos.containsKey(nomeBaralho)) {
      _baralhoAtual = nomeBaralho;
      _cartasExcluidas.clear(); // Limpa exclusões ao trocar baralho
      notifyListeners();
    }
  }

  // Alterna o status de uma carta (incluída/excluída do sorteio)
  void alternarStatusCarta(int cartaId) {
    if (_cartasExcluidas.contains(cartaId)) {
      _cartasExcluidas.remove(cartaId);
    } else {
      _cartasExcluidas.add(cartaId);
    }
    notifyListeners();
  }

  // Define múltiplas cartas como excluídas
  void definirCartasExcluidas(Set<int> cartasIds) {
    _cartasExcluidas = cartasIds;
    notifyListeners();
  }

  // Verifica se uma carta está excluída do sorteio
  bool isCartaExcluida(int cartaId) {
    return _cartasExcluidas.contains(cartaId);
  }

  // Sorteia uma carta aleatória das disponíveis
  CartaModel? sortearCarta() {
    final disponveis = cartasDisponiveis;
    if (disponveis.isEmpty) return null;

    disponveis.shuffle();
    return disponveis.first;
  }

  // Reseta todas as exclusões
  void resetarExclusoes() {
    _cartasExcluidas.clear();
    notifyListeners();
  }
}
