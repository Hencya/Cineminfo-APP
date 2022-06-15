import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_detail.dart';
import 'package:flutter/cupertino.dart';

enum ActorFavouriteViewState {
  none,
  loading,
  error,
}

class ActorFavouriteViewModel with ChangeNotifier {
  ActorFavouriteViewState _state = ActorFavouriteViewState.none;
  ActorFavouriteViewState get state => _state;

  List<CastDetail> _actorFavourite = [];
  List<CastDetail> get actorFavourite => _actorFavourite;

  changeState(ActorFavouriteViewState s) {
    _state = s;
    notifyListeners();
  }

  getActorById(List id) async {
    changeState(ActorFavouriteViewState.loading);
    try {
      for (int i = 0; i < id.length; i++) {
        final c = await TmdbApi.getCastDetail(id[i]);
        _actorFavourite.add(c);
        notifyListeners();
      }
      changeState(ActorFavouriteViewState.none);
    } catch (e) {
      changeState(ActorFavouriteViewState.error);
    }
  }
}
