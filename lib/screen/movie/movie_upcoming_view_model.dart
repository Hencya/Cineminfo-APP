import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum UpcomingViewState { none, loading, error }

class UpcomingViewModel with ChangeNotifier {
  UpcomingViewState _state = UpcomingViewState.none;
  UpcomingViewState get state => _state;

  List<Movie> _moviesUpcoming = [];
  List<Movie> get moviesUpcoming => _moviesUpcoming;

  changeState(UpcomingViewState s) {
    _state = s;
    notifyListeners();
  }

  getUpcomingMovies() async {
    changeState(UpcomingViewState.loading);
    try {
      final c = await TmdbApi.getUpcomingMovie();
      _moviesUpcoming = c;
      notifyListeners();
      changeState(UpcomingViewState.none);
    } catch (e) {
      changeState(UpcomingViewState.error);
    }
  }
}
