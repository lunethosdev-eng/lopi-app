import 'package:flutter/material.dart';
import '../../data/services/api_service.dart';
import '../../core/glassmorphism.dart';
import 'details_screen.dart';
import '../animations/page_transitions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _latestEpisodes;

  @override
  void initState() {
    super.initState();
    ApiService.keepAlive(); // Despierta el servidor de Render al iniciar
    _latestEpisodes = ApiService.fetchLatestEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Lopi Anime", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: LiquidGlassContainer(
            opacity: 0.05,
            borderRadius: BorderRadius.zero,
            child: Container(),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1B4B), Color(0xFF0B0F19)],
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _latestEpisodes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No se pudieron cargar los episodios.\nVerifica tu conexión o el servidor.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final episodes = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 110, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                final ep = episodes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      LiquidPageRoute(
                        child: DetailsScreen(animeTitle: ep['title'], animeUrl: ep['link'], imageUrl: ep['image']),
                      ),
                    );
                  },
                  child: LiquidGlassContainer(
                    opacity: 0.12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: Image.network(
                              ep['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            ep['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
