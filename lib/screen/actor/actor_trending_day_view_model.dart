import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:flutter/cupertino.dart';

enum ActorDayViewState { none, loading, error }

class ActorDayViewModel with ChangeNotifier {
  ActorDayViewState _state = ActorDayViewState.none;
  ActorDayViewState get state => _state;

  List<Person> _actorDay = [];
  List<Person> get actorDay => _actorDay;

  changeState(ActorDayViewState s) {
    _state = s;
    notifyListeners();
  }

  getTrendingDayActor() async {
    changeState(ActorDayViewState.loading);
    try {
      final c = await TmdbApi.getTrendingDayPerson();
      _actorDay = c;
      notifyListeners();
      changeState(ActorDayViewState.none);
    } catch (e) {
      changeState(ActorDayViewState.error);
    }
  }
}
