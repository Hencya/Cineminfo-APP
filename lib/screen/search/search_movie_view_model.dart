import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum SearchMovieViewState {
  none,
  loading,
  error,
}

class SearchMovieViewModel with ChangeNotifier {
  SearchMovieViewState _state = SearchMovieViewState.none;
  SearchMovieViewState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  changeState(SearchMovieViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovies(String query) async {
    changeState(SearchMovieViewState.loading);
    try {
      final c = await TmdbApi.searchMovie(query);
      _movies = c;
      notifyListeners();
      changeState(SearchMovieViewState.none);
    } catch (e) {
      changeState(SearchMovieViewState.error);
    }
  }
}
