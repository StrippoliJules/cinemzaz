import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/tv_show.dart';

class ShowDetailScreen extends StatefulWidget {
  final String showId;
  const ShowDetailScreen({Key? key, required this.showId}) : super(key: key);

  @override
  _ShowDetailScreenState createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  late Future<TVShow> _futureShow;
  final APIService _apiService = APIService();
  
  @override
  void initState() {
    super.initState();
    _futureShow = _apiService.fetchShowDetails(id: widget.showId);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Série'),
      ),
      body: FutureBuilder<TVShow>(
        future: _futureShow,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Aucune donnée trouvée'));
          } else {
            final TVShow show = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Affichage de l'image
                  Center(
                    child: show.image.isNotEmpty
                      ? Image.network(show.image, fit: BoxFit.cover)
                      : Container(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    show.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    show.description ?? 'Pas de description disponible.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
