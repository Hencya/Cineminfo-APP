import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:flutter/cupertino.dart';

enum SearchTvViewState {
  none,
  loading,
  error,
}

class SearchTvViewModel with ChangeNotifier {
  SearchTvViewState _state = SearchTvViewState.none;
  SearchTvViewState get state => _state;

  List<TV> _tvs = [];
  List<TV> get tvs => _tvs;

  changeState(SearchTvViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovies(String query) async {
    changeState(SearchTvViewState.loading);
    try {
      final c = await TmdbApi.searchTv(query);
      _tvs = c;
      notifyListeners();
      changeState(SearchTvViewState.none);
    } catch (e) {
      changeState(SearchTvViewState.error);
    }
  }
}
