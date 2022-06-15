import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum PopularViewState { none, loading, error }

class PopularViewModel with ChangeNotifier {
  PopularViewState _state = PopularViewState.none;
  PopularViewState get state => _state;

  List<Movie> _moviesPopular = [];
  List<Movie> get moviesPopular => _moviesPopular;

  changeState(PopularViewState s) {
    _state = s;
    notifyListeners();
  }

  getPopularMovies() async {
    changeState(PopularViewState.loading);
    try {
      final c = await TmdbApi.getPopularMovie();
      _moviesPopular = c;
      notifyListeners();
      changeState(PopularViewState.none);
    } catch (e) {
      changeState(PopularViewState.error);
    }
  }
}
