import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_detail.dart';
import 'package:flutter/cupertino.dart';

enum DetailTvViewState {
  none,
  loading,
  error,
}

class DetailTvViewModel with ChangeNotifier {
  DetailTvViewState _state = DetailTvViewState.none;
  DetailTvViewState get state => _state;

  TvDetail? tvDetail;

  changeState(DetailTvViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovieDetail(int id) async {
    changeState(DetailTvViewState.loading);
    try {
      final c = await TmdbApi.getTvDetail(id);
      tvDetail = c;
      notifyListeners();
      changeState(DetailTvViewState.none);
    } catch (e) {
      changeState(DetailTvViewState.error);
    }
  }
}
