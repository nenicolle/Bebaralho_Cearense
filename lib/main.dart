import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'features/sorteador/presentation/pages/tela_inicial_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bebaralho Cearense',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const TelaInicialPage(),
    );
  }
}
