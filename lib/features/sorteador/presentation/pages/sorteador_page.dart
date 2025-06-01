// lib/features/sorteador/presentation/pages/sorteador_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/sorteador_provider.dart';
import '../widgets/carta_widget.dart';
import 'tela_inicial_page.dart';

class SorteadorPage extends StatefulWidget {
  const SorteadorPage({super.key});

  @override
  State<SorteadorPage> createState() => _SorteadorPageState();
}

class _SorteadorPageState extends State<SorteadorPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SorteadorProvider>(context).controller;

    void proximaCarta() {
      setState(() => controller.proximaCarta());
    }

    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) proximaCarta();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CartaWidget(imagePath: controller.cartaAtual),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: proximaCarta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Próxima Carta'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const TelaInicialPage()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Parar Jogo'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ou deslize para a esquerda para avançar',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
