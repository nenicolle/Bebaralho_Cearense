// lib/features/sorteador/presentation/pages/deck_selection_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/sorteador_provider.dart';
import '../widgets/carta_widget.dart';

class DeckSelectionPage extends StatefulWidget {
  const DeckSelectionPage({super.key});

  @override
  State<DeckSelectionPage> createState() => _DeckSelectionPageState();
}

class _DeckSelectionPageState extends State<DeckSelectionPage> {
  late List<String> allCards;
  late List<bool> selectedCards;

  @override
  void initState() {
    super.initState();
    final controller =
        Provider.of<SorteadorProvider>(context, listen: false).controller;
    allCards = controller.getAllCards();
    selectedCards =
        allCards
            .map((card) => controller.selectedCards.contains(card))
            .toList();
  }

  void toggleCardSelection(int index) {
    setState(() {
      selectedCards[index] = !selectedCards[index];
    });
  }

  void saveSelectedCards(BuildContext context) {
    List<String> chosenCards = [];
    for (int i = 0; i < allCards.length; i++) {
      if (selectedCards[i]) {
        chosenCards.add(allCards[i]);
      }
    }
    Provider.of<SorteadorProvider>(
      context,
      listen: false,
    ).updateSelectedCards(chosenCards);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Seleção de Baralho'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'save') {
                saveSelectedCards(context);
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'save',
                    child: Text('Salvar Seleção'),
                  ),
                ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: allCards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => toggleCardSelection(index),
            child: Stack(
              children: [
                CartaWidget(imagePath: allCards[index]),
                if (!selectedCards[index])
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.red, size: 40),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
