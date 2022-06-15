import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:flutter/cupertino.dart';

enum TvTopRatedViewState { none, loading, error }

class TvTopRatedViewModel with ChangeNotifier {
  TvTopRatedViewState _state = TvTopRatedViewState.none;
  TvTopRatedViewState get state => _state;

  List<TV> _tvTopRated = [];
  List<TV> get tvTopRated => _tvTopRated;

  changeState(TvTopRatedViewState s) {
    _state = s;
    notifyListeners();
  }

  getTvTopRated() async {
    changeState(TvTopRatedViewState.loading);
    try {
      final c = await TmdbApi.getTvTopRated();
      _tvTopRated = c;
      notifyListeners();
      changeState(TvTopRatedViewState.none);
    } catch (e) {
      changeState(TvTopRatedViewState.error);
    }
  }
}
