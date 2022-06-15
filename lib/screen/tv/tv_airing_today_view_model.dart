import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:flutter/cupertino.dart';

enum TvAiringViewState { none, loading, error }

class TvAiringViewModel with ChangeNotifier {
  TvAiringViewState _state = TvAiringViewState.none;
  TvAiringViewState get state => _state;

  List<TV> _tvAiring = [];
  List<TV> get tvAiring => _tvAiring;

  changeState(TvAiringViewState s) {
    _state = s;
    notifyListeners();
  }

  getTvAiring() async {
    changeState(TvAiringViewState.loading);
    try {
      final c = await TmdbApi.getTvAiring();
      _tvAiring = c;
      notifyListeners();
      changeState(TvAiringViewState.none);
    } catch (e) {
      changeState(TvAiringViewState.error);
    }
  }
}
