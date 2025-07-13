// editar_avatar_modal.dart

import 'package:flutter/material.dart';
import 'package:bebaralho/models/player_model.dart';

class EditarAvatarModal extends StatelessWidget {
  final Jogador jogador;
  final void Function(String avatarSelecionado) onAvatarSelecionado;

  const EditarAvatarModal({
    super.key,
    required this.jogador,
    required this.onAvatarSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> avatarList = List.generate(
      12,
      (index) => 'assets/profileImages/${index + 1}.png',
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                'Escolha seu avatar, ${jogador.nome}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: avatarList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final avatar = avatarList[index];
                  return GestureDetector(
                    onTap: () {
                      onAvatarSelecionado(avatar);
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(avatar),
                      backgroundColor: Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
