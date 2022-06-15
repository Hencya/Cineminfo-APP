import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:equatable/equatable.dart';

class GenreList extends Equatable {
  final List<Genre>? genres;

  const GenreList({this.genres});

  factory GenreList.fromJson(Map<String, dynamic> json) {
    return GenreList(
      genres: (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
    );
  }

  @override
  List<Object?> get props => [genres];
}
