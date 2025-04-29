import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorteador de Cartas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SorteadorPage(),
    );
  }
}

class SorteadorPage extends StatefulWidget {
  const SorteadorPage({super.key});

  @override
  State<SorteadorPage> createState() => _SorteadorPageState();
}

class _SorteadorPageState extends State<SorteadorPage> {
  final List<String> cartas = List.generate(
    82,
    (index) => 'assets/${index + 1}.jpg',
  );

  late List<String> cartasEmbaralhadas;
  int cartaAtualIndex = 0;

  @override
  void initState() {
    super.initState();
    _embaralharCartas();
  }

  void _embaralharCartas() {
    cartasEmbaralhadas = List.from(cartas);
    cartasEmbaralhadas.shuffle(); // Embaralha as cartas
    cartaAtualIndex = 0;
  }

  void proximaCarta() {
    setState(() {
      cartaAtualIndex++;
      if (cartaAtualIndex >= cartasEmbaralhadas.length) {
        _embaralharCartas(); // Se acabou todas, reembaralha
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242), // Fundo cinza
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            proximaCarta(); // Deslizar para esquerda = próxima carta
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                cartasEmbaralhadas[cartaAtualIndex],
                height: 650,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: proximaCarta,
                child: const Text('Próxima Carta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
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
