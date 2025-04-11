import 'package:flutter/material.dart';
import '../models/tv_show.dart';
import '../services/api_service.dart';

class TVShowsProvider extends ChangeNotifier {
  final APIService _apiService = APIService();

  List<TVShow> _tvShows = [];
  bool _isLoading = false;
  String _error = '';
  String _query = '';
  int _currentPage = 1;

  List<TVShow> get tvShows => _tvShows;
  bool get isLoading => _isLoading;
  String get error => _error;
  int get currentPage => _currentPage;

  Future<void> fetchTVShows({int? page}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    final int fetchPage = page ?? _currentPage;

    try {
      List<TVShow> shows;
      if (_query.isNotEmpty) {
        shows = await _apiService.searchShows(query: _query, page: fetchPage);
      } else {
        shows = await _apiService.fetchPopularShows(page: fetchPage);
      }

      _tvShows = shows;
      _currentPage = fetchPage;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    fetchTVShows(page: _currentPage + 1);
  }

  void previousPage() {
    if (_currentPage > 1) {
      fetchTVShows(page: _currentPage - 1);
    }
  }

  void setQuery(String query) {
    _query = query;
    _currentPage = 1;
    fetchTVShows(page: 1);
  }

  void clearQuery() {
    _query = '';
    _currentPage = 1;
    fetchTVShows(page: 1);
  }
}
