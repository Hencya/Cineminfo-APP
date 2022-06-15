import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/tv/tv_detail.dart';
import 'package:flutter/cupertino.dart';

enum TvFavouriteViewState {
  none,
  loading,
  error,
}

class TvFavouriteViewModel with ChangeNotifier {
  TvFavouriteViewState _state = TvFavouriteViewState.none;
  TvFavouriteViewState get state => _state;

  List<TvDetail> _tvFavourite = [];
  List<TvDetail> get tvFavourite => _tvFavourite;

  changeState(TvFavouriteViewState s) {
    _state = s;
    notifyListeners();
  }

  getTvById(List id) async {
    changeState(TvFavouriteViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await TmdbApi.getTvDetail(id[i]);
        _tvFavourite.add(c);
        notifyListeners();
      }
      changeState(TvFavouriteViewState.none);
    } catch (e) {
      changeState(TvFavouriteViewState.error);
    }
  }
}
