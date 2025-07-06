import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/sorteador_provider.dart';
import '../widgets/carta_widget.dart';
import '../../../home/home_page.dart';

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
      backgroundColor: const Color(0xFFb0c0ca),
      body: Stack(
        children: [
          Column(
            children: [
              _buildCustomHeader(context),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < 0) proximaCarta();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        Container(
                          width: 260,
                          height: 390,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child:
                                CartaWidget(imagePath: controller.cartaAtual),
                          ),
                        ),
                        const Spacer(flex: 1),
                        const SizedBox(height: 20),
                        const Text(
                          'Deslize para a esquerda para avançar',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 150,
        color: const Color(0xFFa2b4c0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () {
                  // TODO: Lógica para abrir o menu
                },
              ),
              IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
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
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
