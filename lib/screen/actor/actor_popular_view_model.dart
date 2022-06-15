import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:flutter/cupertino.dart';

enum ActorPopularViewState { none, loading, error }

class ActorPopularViewModel with ChangeNotifier {
  ActorPopularViewState _state = ActorPopularViewState.none;
  ActorPopularViewState get state => _state;

  List<Person> _actorPopular = [];
  List<Person> get actorPopular => _actorPopular;

  changeState(ActorPopularViewState s) {
    _state = s;
    notifyListeners();
  }

  getPopularActor() async {
    changeState(ActorPopularViewState.loading);
    try {
      final c = await TmdbApi.getPopularPerson();
      _actorPopular = c;
      notifyListeners();
      changeState(ActorPopularViewState.none);
    } catch (e) {
      changeState(ActorPopularViewState.error);
    }
  }
}
