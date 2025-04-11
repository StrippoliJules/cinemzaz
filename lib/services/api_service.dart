import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_show.dart';

class APIService {
  static const String baseUrl = 'https://www.episodate.com/api';

  Future<List<TVShow>> fetchPopularShows({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/most-popular?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List showsList = data['tv_shows'];
      return showsList.map((show) => TVShow.fromPopularJson(show)).toList();
    } else {
      throw Exception('Erreur lors du chargement des séries populaires');
    }
  }

  Future<List<TVShow>> searchShows({required String query, int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query&page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List showsList = data['tv_shows'];
      return showsList.map((show) => TVShow.fromPopularJson(show)).toList();
    } else {
      throw Exception('Erreur lors de la recherche de la série');
    }
  }

  Future<TVShow> fetchShowDetails({required String id}) async {
    final response = await http.get(Uri.parse('$baseUrl/show-details?q=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, dynamic> showData = data['tvShow'];
      return TVShow.fromDetailsJson(showData);
    } else {
      throw Exception('Erreur lors de la récupération des détails de la série');
    }
  }
}
