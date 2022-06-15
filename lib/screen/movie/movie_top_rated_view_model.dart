import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum TopRatedViewState { none, loading, error }

class TopRatedViewModel with ChangeNotifier {
  TopRatedViewState _state = TopRatedViewState.none;
  TopRatedViewState get state => _state;

  List<Movie> _moviesTopRated = [];
  List<Movie> get moviesTopRated => _moviesTopRated;

  changeState(TopRatedViewState s) {
    _state = s;
    notifyListeners();
  }

  getTopRatedMovies() async {
    changeState(TopRatedViewState.loading);
    try {
      final c = await TmdbApi.getTopRatedMovie();
      _moviesTopRated = c;
      notifyListeners();
      changeState(TopRatedViewState.none);
    } catch (e) {
      changeState(TopRatedViewState.error);
    }
  }
}
