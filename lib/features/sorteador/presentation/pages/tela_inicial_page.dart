import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bebaralho/features/home/home_page.dart';
import 'package:video_player/video_player.dart';

class TelaInicialPage extends StatefulWidget {
  const TelaInicialPage({super.key});

  @override
  State<TelaInicialPage> createState() => _TelaInicialPageState();
}

class _TelaInicialPageState extends State<TelaInicialPage> {
  String _version = '...';
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller =
          VideoPlayerController.asset('assets/videos/opening-video.mp4');
      await _controller.initialize();
      _controller.setVolume(0);
      _controller.setLooping(true);
      await _controller.play();
      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Erro ao carregar vídeo: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        backgroundColor: const Color.fromARGB(255, 43, 58, 80),
        body: Stack(
          children: [
            if (_hasError)
              const Center(child: Text("Erro ao carregar vídeo."))
            else if (!_isVideoInitialized)
              const Center(child: CircularProgressIndicator())
            else
              Transform.translate(
                offset: const Offset(-15, 0), // desloca 5px para a esquerda
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
            SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 16,
                    child: Text(
                      'ver. $_version',
                      style: const TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Toque para iniciar',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xFFCCCCCC),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
