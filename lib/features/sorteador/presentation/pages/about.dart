import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      appBar: AppBar(
        title: const Text('SOBRE O JOGO'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '- SOBRE O JOGO -',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'O objetivo do jogo é frescar com os amigos.\n\n'
                'As regras são:\n'
                '• não morrer\n'
                '• não parar na UPA.\n\n'
                'Lembre que dirigir e beber é coisa de arrombado.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 32),
              const Text(
                'SIGNIFICADO DOS ÍCONES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.local_drink, color: Colors.white),
                  SizedBox(width: 8),
                  Icon(Icons.local_drink, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'CADA COPO É UMA GOLADA BEM DADA',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.asset(
                    'assets/drinking_water.png', // caminho da sua imagem
                    width: 24,
                    height: 24,
                    color:
                        Colors
                            .white, // opcional (só funciona se o PNG for preto/branco com canal alpha)
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'UM COPO D’ÁGUA',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Text(
                'O jogo foi pensado pra ser jogado com drinks grandes,\n'
                'mas se quiser ir no shot, BOA SORTE.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
