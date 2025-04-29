import 'package:estudos/features/sorteador/presentation/pages/rules.dart';
import 'package:flutter/material.dart';
import 'sorteador_page.dart';

class TelaInicialPage extends StatelessWidget {
  const TelaInicialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/icone_imagem.png',
              height: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const RulesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                textStyle: const TextStyle(fontSize: 24),
              ),
              child: const Text('Iniciar Jogo'),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'feito por @nenicolle',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
