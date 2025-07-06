import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estudos/features/sorteador/controller/sorteador_provider.dart';
import 'package:estudos/features/sorteador/presentation/pages/deck_selection_page.dart';
import 'package:estudos/features/sorteador/presentation/pages/sorteador_page.dart';

class DeckStartPage extends StatelessWidget {
  final String baralhoSelecionado;

  const DeckStartPage({super.key, required this.baralhoSelecionado});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SorteadorProvider>(context, listen: false);
    provider.trocarBaralho(baralhoSelecionado);

    void startGameWithAllCards() {
      final allCards = provider.controller.getAllCards();
      provider.updateSelectedCards(allCards);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SorteadorPage()),
      );
    }

    void goToCardSelection() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              DeckSelectionPage(baralhoSelecionado: baralhoSelecionado),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFb0c0ca),
      body: Stack(
        children: [
          Column(
            children: [
              _buildCustomHeader(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      Container(
                        width: 220,
                        height: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            'assets/capa-$baralhoSelecionado.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Text(
                                'Erro ao carregar capa',
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            label: 'Mixar',
                            onPressed: goToCardSelection,
                          ),
                          _buildActionButton(
                            label: 'Começar',
                            onPressed: startGameWithAllCards,
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFd4dbe0),
        foregroundColor: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        elevation: 5,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: Colors.white, size: 30),
                onPressed: () {},
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
