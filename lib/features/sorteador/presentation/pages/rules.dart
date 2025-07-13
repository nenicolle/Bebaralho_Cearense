import 'package:bebaralho/features/sorteador/presentation/pages/sorteador_page.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regras')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Regras do Jogo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Funciona assim: Faça uma roda com seus amigos e decidam quem vai começar o jogo, podem usar qualquer critério.\n'
              'Pode ser o mais alto, o mais da galera, o que tem a cabeça maior, isso não importa.\n'
              'OS OBJETIVOS DO JOGO SÃO: \n'
              '- Não morrer\n'
              '- Não se apaixonar\n'
              '- Não fazer criança\n'
              '- Não parar na UPA\n'
              'É só puxar a carta, fazer a ação da carta e ser feliz.\n'
              'Bom jogo e beba com moderação.\n',
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SorteadorPage()),
                  );
                },
                child: const Text('Entendi, vamos jogar!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
