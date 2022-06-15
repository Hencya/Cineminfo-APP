import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_detail.dart';
import 'package:flutter/cupertino.dart';

enum DetailMovieViewState {
  none,
  loading,
  error,
}

class DetailMovieViewModel with ChangeNotifier {
  DetailMovieViewState _state = DetailMovieViewState.none;
  DetailMovieViewState get state => _state;

  MovieDetail? movieDetail;

  changeState(DetailMovieViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieDetail(int id) async {
    changeState(DetailMovieViewState.loading);
    try {
      final c = await TmdbApi.getMovieDetail(id);
      movieDetail = c;
      notifyListeners();
      changeState(DetailMovieViewState.none);
    } catch (e) {
      changeState(DetailMovieViewState.error);
    }
  }
}
