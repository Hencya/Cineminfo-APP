import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:flutter/cupertino.dart';

enum TvPopularViewState { none, loading, error }

class TvPopularViewModel with ChangeNotifier {
  TvPopularViewState _state = TvPopularViewState.none;
  TvPopularViewState get state => _state;

  List<TV> _tvPopular = [];
  List<TV> get tvPopular => _tvPopular;

  changeState(TvPopularViewState s) {
    _state = s;
    notifyListeners();
  }

  getTvPopular() async {
    changeState(TvPopularViewState.loading);
    try {
      final c = await TmdbApi.getTvPopular();
      _tvPopular = c;
      notifyListeners();
      changeState(TvPopularViewState.none);
    } catch (e) {
      changeState(TvPopularViewState.error);
    }
  }
}
