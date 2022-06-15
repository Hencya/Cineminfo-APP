import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum GenreViewState { none, loading, error }

class GenreViewModel with ChangeNotifier {
  GenreViewState _state = GenreViewState.none;
  GenreViewState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  changeState(GenreViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieByGenre(int id) async {
    changeState(GenreViewState.loading);
    try {
      final c = await TmdbApi.getMovieByGenre(id);
      _movies = c;
      notifyListeners();
      changeState(GenreViewState.none);
    } catch (e) {
      changeState(GenreViewState.error);
    }
  }
}
