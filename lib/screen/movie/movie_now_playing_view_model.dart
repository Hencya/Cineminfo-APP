import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';

enum NowPlayingViewState { none, loading, error }

class NowPlayingViewModel with ChangeNotifier {
  NowPlayingViewState _state = NowPlayingViewState.none;
  NowPlayingViewState get state => _state;

  List<Movie> _moviesNowPlay = [];
  List<Movie> get moviesNowPlay => _moviesNowPlay;

  changeState(NowPlayingViewState s) {
    _state = s;
    notifyListeners();
  }

  getNowPlayingMovies() async {
    changeState(NowPlayingViewState.loading);
    try {
      final c = await TmdbApi.getNowPlayingMovie();
      _moviesNowPlay = c;
      notifyListeners();
      changeState(NowPlayingViewState.none);
    } catch (e) {
      changeState(NowPlayingViewState.error);
    }
  }
}
