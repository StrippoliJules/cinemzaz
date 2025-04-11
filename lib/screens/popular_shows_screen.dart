import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tv_shows_provider.dart';
import 'show_detail_screen.dart';
import '../models/tv_show.dart';

class PopularShowsScreen extends StatefulWidget {
  const PopularShowsScreen({Key? key}) : super(key: key);

  @override
  _PopularShowsScreenState createState() => _PopularShowsScreenState();
}

class _PopularShowsScreenState extends State<PopularShowsScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Chargement initial des séries
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TVShowsProvider>(context, listen: false).fetchTVShows();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  void _onSearch() {
    String query = _searchController.text.trim();
    Provider.of<TVShowsProvider>(context, listen: false).setQuery(query);
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TVShowsProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              Provider.of<TVShowsProvider>(context, listen: false).clearQuery();
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Recherche une série...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onSubmitted: (value) => _onSearch(),
            ),
          ),
          // Affichage d’un message d’erreur le cas échéant
          if (provider.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(provider.error, style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: provider.isLoading 
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provider.tvShows.length,
                itemBuilder: (context, index) {
                  TVShow show = provider.tvShows[index];
                  return ListTile(
                    leading: show.image.isNotEmpty 
                      ? Image.network(show.image, width: 50, fit: BoxFit.cover)
                      : null,
                    title: Text(show.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShowDetailScreen(showId: show.id),
                        ),
                      );
                    },
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}