//PAGINA DE SELEÇÃO DE CARTAS DO BARALHO
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bebaralho/features/sorteador/controller/sorteador_provider.dart';
import 'package:bebaralho/features/sorteador/presentation/widgets/carta_widget.dart';

class DeckSelectionPage extends StatefulWidget {
  final String baralhoSelecionado;

  const DeckSelectionPage({super.key, required this.baralhoSelecionado});

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
    controller.trocarBaralho(widget.baralhoSelecionado);
    allCards = controller.getAllCards();
    selectedCards = allCards
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
      backgroundColor: const Color(0xFFc5d1d9),
      body: Column(
        // Removido o Stack desnecessário que envolvia a Column
        children: [
          _buildCustomHeader(context),
          Expanded(
            child: GridView.builder(
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
                  // **CORREÇÃO 1: Padding para ajustar a largura da carta**
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        // Opcional: A sombra pode ficar aqui ou no CartaWidget
                        // Para um efeito mais limpo, muitas vezes é melhor
                        // ter a sombra e o arredondamento no mesmo widget.
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        fit: StackFit
                            .expand, // Garante que o Stack preencha o Container
                        children: [
                          CartaWidget(imagePath: allCards[index]),
                          if (!selectedCards[index])
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFc5d1d9).withOpacity(0.8),
                                // **CORREÇÃO 2: Borda arredondada na camada escura**
                                // Este valor deve ser o mesmo do seu CartaWidget.
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 150,
        color: const Color(0xFFa2b4c0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 80),
                child: Text(
                  'Seleção de cartas',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.save,
                    color: Color.fromARGB(255, 23, 49, 88), size: 30),
                tooltip: 'Salvar Seleção',
                onPressed: () => saveSelectedCards(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
