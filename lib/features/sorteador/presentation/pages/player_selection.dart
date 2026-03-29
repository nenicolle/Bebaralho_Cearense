//PAGINA DE ADIÇÃO DE JOGADORES
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bebaralho/models/player_model.dart';
import 'package:bebaralho/features/sorteador/presentation/pages/edit_avatar_page.dart';

class PlayerSelectionPage extends StatefulWidget {
  const PlayerSelectionPage({super.key});

  @override
  State<PlayerSelectionPage> createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
  List<Jogador> jogadores = [];

  @override
  void initState() {
    super.initState();
    carregarJogadores();
  }

  Future<void> carregarJogadores() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('jogadores');
    if (data != null) {
      final list = jsonDecode(data) as List;
      setState(() {
        jogadores = list.map((e) => Jogador.fromJson(e)).toList();
      });
    }
  }

  Future<void> salvarJogadores() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(jogadores.map((e) => e.toJson()).toList());
    await prefs.setString('jogadores', data);
  }

  void adicionarJogador() {
    if (jogadores.length >= 5) return;

    setState(() {
      jogadores.add(
        Jogador(
          nome: jogadores.isEmpty ? 'Eu' : 'Jogador ${jogadores.length + 1}',
          avatar: 'assets/profileImages/1.png',
        ),
      );
    });

    salvarJogadores();
  }

  void removerJogador(int index) {
    setState(() {
      jogadores.removeAt(index);
    });

    salvarJogadores();
  }

  void editarNomeJogador(int index) async {
    final TextEditingController controller =
        TextEditingController(text: jogadores[index].nome);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar nome do jogador'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Digite o novo nome'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  jogadores[index] = Jogador(
                    nome: controller.text.trim().isEmpty
                        ? jogadores[index].nome
                        : controller.text.trim(),
                    avatar: jogadores[index].avatar,
                  );
                });
                salvarJogadores();
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void abrirEditorDeAvatar(Jogador jogador, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditarAvatarModal(
        jogador: jogador,
        onAvatarSelecionado: (novoAvatar) {
          setState(() {
            jogadores[index] = Jogador(
              nome: jogadores[index].nome,
              avatar: novoAvatar,
            );
          });
          salvarJogadores();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8D9DA9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Jogadores'),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ...jogadores.asMap().entries.map((entry) {
            final index = entry.key;
            final jogador = entry.value;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => abrirEditorDeAvatar(jogador, index),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(jogador.avatar),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => editarNomeJogador(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            jogador.nome,
                            style: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.red),
                      onPressed: () => removerJogador(index),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (jogadores.length >= 5)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("máx 5 jogadores",
                  style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      floatingActionButton: jogadores.length < 5
          ? FloatingActionButton(
              onPressed: adicionarJogador,
              backgroundColor: Colors.white,
              child: const Icon(Icons.add, color: Colors.black),
            )
          : null,
    );
  }
}
