import 'package:flutter/material.dart';
import 'package:estudos/features/sorteador/presentation/pages/deck_start_page.dart';
import 'package:estudos/features/sorteador/presentation/pages/tela_inicial_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFc5d1d9),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              _buildCustomHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      top: 70, left: 24, right: 24, bottom: 24),
                  child: Column(
                    children: [
                      _buildDeckSection(context),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                      const SizedBox(height: 24),
                      _buildStoreButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 135,
            child: SizedBox(
              height: 90,
              width: 90,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFFc5d1d9),
                  elevation: 8.0,
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                child: const Text('perfil',
                    style: TextStyle(color: Color(0xFF333333))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeckSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFd4dbe0),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDeckCard(
            context,
            baralho: 'bebaralho-cearense',
            imagem: 'assets/capa-bebaralho-cearense.png',
          ),
          const SizedBox(width: 16),
          _buildDeckCard(
            context,
            baralho: 'hipoteticamente',
            imagem: 'assets/capa-hipoteticamente.png',
          ),
        ],
      ),
    );
  }

  Widget _buildDeckCard(BuildContext context,
      {required String baralho, required String imagem}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DeckStartPage(baralhoSelecionado: baralho),
          ),
        );
      },
      child: Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFa2b4c0),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagem,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'Erro ao carregar',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(icon: Icons.filter_1_sharp, label: 'Criar'),
        _buildActionButton(icon: Icons.shuffle, label: 'Mix'),
      ],
    );
  }

  Widget _buildStoreButton() {
    return _buildActionButton(
        icon: Icons.storefront, label: 'Loja', isFullWidth: true);
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      bool isFullWidth = false}) {
    final buttonContent = Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFd4dbe0),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: const Color(0xFF333333)),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 16, color: Color(0xFF333333))),
        ],
      ),
    );

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: buttonContent,
      );
    }

    return SizedBox(
      width: 160,
      child: buttonContent,
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 200,
        color: const Color(0xFFa2b4c0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.exit_to_app,
                    color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TelaInicialPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: Colors.white, size: 30),
                onPressed: () {
                  // TODO: Lógica para o botão de adicionar
                },
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
    path.lineTo(0, size.height - 80);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 120);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
