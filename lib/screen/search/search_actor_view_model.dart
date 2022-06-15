import 'package:cineminfo/model/api/tmdb_api.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:flutter/cupertino.dart';

enum SearchActorViewState {
  none,
  loading,
  error,
}

class SearchActorViewModel with ChangeNotifier {
  SearchActorViewState _state = SearchActorViewState.none;
  SearchActorViewState get state => _state;

  List<Person> _persons = [];
  List<Person> get persons => _persons;

  changeState(SearchActorViewState s) {
    _state = s;
    notifyListeners();
  }

  getMovies(String query) async {
    changeState(SearchActorViewState.loading);
    try {
      final c = await TmdbApi.searchPerson(query);
      _persons = c;
      notifyListeners();
      changeState(SearchActorViewState.none);
    } catch (e) {
      changeState(SearchActorViewState.error);
    }
  }
}
