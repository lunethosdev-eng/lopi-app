import 'package:flutter/material.dart';
import '../../core/glassmorphism.dart';
import 'player_screen.dart';
import '../animations/page_transitions.dart';

class DetailsScreen extends StatelessWidget {
  final String animeTitle;
  final String animeUrl;
  final String imageUrl;

  const DetailsScreen({Key? key, required this.animeTitle, required this.animeUrl, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.4), const Color(0xFF0B0F19)],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(animeTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text("Opciones de reproducción / Servidores", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.withOpacity(0.8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        LiquidPageRoute(child: const PlayerScreen(videoUrl: "https://www.w3schools.com/html/mov_bbb.mp4")),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text("Reproducir Episodio (Español / Sub)"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
