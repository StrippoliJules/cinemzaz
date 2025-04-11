import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tv_shows_provider.dart';
import 'show_detail_screen.dart';
import '../models/tv_show.dart';

class PopularShowsScreen extends StatefulWidget {
  const PopularShowsScreen({super.key});

  @override
  State<PopularShowsScreen> createState() => _PopularShowsScreenState();
}

class _PopularShowsScreenState extends State<PopularShowsScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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
        title: const Text('Cinemzaz'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 600),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        onSubmitted: (_) => _onSearch(),
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Recherche une série...',
                          filled: true,
                          fillColor: Colors.grey[850],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () {
                                    _searchController.clear();
                                    Provider.of<TVShowsProvider>(context,
                                            listen: false)
                                        .clearQuery();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _onSearch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(0, 44),
                      ),
                      child: const Icon(Icons.search, size: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (provider.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(provider.error,
                  style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final double screenWidth = constraints.maxWidth;
                      final int crossAxisCount =
                          (screenWidth / 160).floor().clamp(2, 6);

                      return GridView.builder(
                        itemCount: provider.tvShows.length,
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          TVShow show = provider.tvShows[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ShowDetailScreen(showId: show.id),
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: show.image.isNotEmpty
                                        ? Image.network(
                                            show.image,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(color: Colors.grey),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      color: Colors.black.withOpacity(0.6),
                                      child: Text(
                                        show.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
