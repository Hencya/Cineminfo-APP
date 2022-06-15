import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_detail.dart';
import 'package:flutter/cupertino.dart';

enum DetailCastViewState {
  none,
  loading,
  error,
}

class DetailCastViewModel with ChangeNotifier {
  DetailCastViewState _state = DetailCastViewState.none;
  DetailCastViewState get state => _state;

  CastDetail? castDetail;

  changeState(DetailCastViewState s) {
    _state = s;
    notifyListeners();
  }

  getCastDetail(int id) async {
    changeState(DetailCastViewState.loading);
    try {
      final c = await TmdbApi.getCastDetail(id);
      castDetail = c;
      notifyListeners();
      changeState(DetailCastViewState.none);
    } catch (e) {
      changeState(DetailCastViewState.error);
    }
  }
}
