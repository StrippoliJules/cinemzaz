import 'package:flutter/material.dart';
import '../models/tv_show.dart';
import '../services/api_service.dart';

class TVShowsProvider extends ChangeNotifier {
  final APIService _apiService = APIService();
  
  List<TVShow> _tvShows = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  String _query = '';
  
  List<TVShow> get tvShows => _tvShows;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  Future<void> fetchTVShows({int page = 1}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    
    try {
      List<TVShow> shows;
      if (_query.isNotEmpty) {
        shows = await _apiService.searchShows(query: _query, page: page);
      } else {
        shows = await _apiService.fetchPopularShows(page: page);
      }
      _tvShows = shows;
      _currentPage = page;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void setQuery(String query) {
    _query = query;
    fetchTVShows(page: 1);
  }
  
  void clearQuery() {
    _query = '';
    fetchTVShows(page: 1);
  }
}
