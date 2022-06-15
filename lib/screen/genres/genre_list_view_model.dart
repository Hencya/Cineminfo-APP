import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:flutter/cupertino.dart';

enum GenreListViewState { none, loading, error }

class GenreListViewModel with ChangeNotifier {
  GenreListViewState _state = GenreListViewState.none;
  GenreListViewState get state => _state;

  List<Genre> _genres = [];
  List<Genre> get genres => _genres;

  changeState(GenreListViewState s) {
    _state = s;
    notifyListeners();
  }

  getGenreList() async {
    changeState(GenreListViewState.loading);
    try {
      final c = await TmdbApi.getGenreList();
      _genres = c;
      notifyListeners();
      changeState(GenreListViewState.none);
    } catch (e) {
      changeState(GenreListViewState.error);
    }
  }
}
