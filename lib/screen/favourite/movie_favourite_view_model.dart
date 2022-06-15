import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/movie/movie_detail.dart';
import 'package:flutter/cupertino.dart';

enum MovieFavouriteViewState {
  none,
  loading,
  error,
}

class MovieFavouriteViewModel with ChangeNotifier {
  MovieFavouriteViewState _state = MovieFavouriteViewState.none;
  MovieFavouriteViewState get state => _state;

  List<MovieDetail> _movieFavourite = [];
  List<MovieDetail> get movieFavourite => _movieFavourite;

  changeState(MovieFavouriteViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieById(List id) async {
    changeState(MovieFavouriteViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await TmdbApi.getMovieDetail(id[i]);
        _movieFavourite.add(c);
        notifyListeners();
      }
      changeState(MovieFavouriteViewState.none);
    } catch (e) {
      changeState(MovieFavouriteViewState.error);
    }
  }
}
