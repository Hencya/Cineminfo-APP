import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:flutter/cupertino.dart';

enum TvOnTheAirViewState { none, loading, error }

class TvOnTheAirViewModel with ChangeNotifier {
  TvOnTheAirViewState _state = TvOnTheAirViewState.none;
  TvOnTheAirViewState get state => _state;

  List<TV> _tvOnTheAir = [];
  List<TV> get tvOnTheAir => _tvOnTheAir;

  changeState(TvOnTheAirViewState s) {
    _state = s;
    notifyListeners();
  }

  getTvOntheAir() async {
    changeState(TvOnTheAirViewState.loading);
    try {
      final c = await TmdbApi.getTvOnTheAir();
      _tvOnTheAir = c;
      notifyListeners();
      changeState(TvOnTheAirViewState.none);
    } catch (e) {
      changeState(TvOnTheAirViewState.error);
    }
  }
}
