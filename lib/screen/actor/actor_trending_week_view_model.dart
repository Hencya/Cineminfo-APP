import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:flutter/cupertino.dart';

enum ActorWeekViewState { none, loading, error }

class ActorWeekViewModel with ChangeNotifier {
  ActorWeekViewState _state = ActorWeekViewState.none;
  ActorWeekViewState get state => _state;

  List<Person> _actorWeek = [];
  List<Person> get actorWeek => _actorWeek;

  changeState(ActorWeekViewState s) {
    _state = s;
    notifyListeners();
  }

  getTrendingWeekActor() async {
    changeState(ActorWeekViewState.loading);
    try {
      final c = await TmdbApi.getTrendingWeekPerson();
      _actorWeek = c;
      notifyListeners();
      changeState(ActorWeekViewState.none);
    } catch (e) {
      changeState(ActorWeekViewState.error);
    }
  }
}
