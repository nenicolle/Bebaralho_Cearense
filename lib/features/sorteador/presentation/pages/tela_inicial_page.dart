import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:estudos/features/home/home_page.dart';

class TelaInicialPage extends StatefulWidget {
  const TelaInicialPage({super.key});

  @override
  State<TelaInicialPage> createState() => _TelaInicialPageState();
}

class _TelaInicialPageState extends State<TelaInicialPage> {
  String _version = '...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFa2b4c0),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ver. $_version',
                style: const TextStyle(color: Color(0xFF333333), fontSize: 14),
                maxLines: 2,
              ),
            ),
          ),
          actions: [],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icone_imagem.png',
                height: 400,
                width: 350,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              const Text(
                'Toque para iniciar',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
