import 'package:cineminfo/model/cast/cast_list_model.dart';
import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:cineminfo/model/tv/tv_images.dart';
import 'package:cineminfo/model/tv/tv_model.dart';

class TvDetail {
  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? id;
  final String? name;
  final String? numberOfSeasons;
  final String? overview;
  final String? posterPath;
  final String? voteAverage;
  final String? voteCount;

  late String? trailerId;
  late TvImages? tvImages;
  late List<TV> similarTv;
  late List<TV> recomendationTv;
  late List<Cast>? castList;

  TvDetail(
      {this.backdropPath,
      this.firstAirDate,
      this.genres,
      this.id,
      this.name,
      this.numberOfSeasons,
      this.overview,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  factory TvDetail.fromJson(Map<String, dynamic> json) => TvDetail(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'],
        genres: (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
        id: json['id'].toString(),
        name: json['name'],
        numberOfSeasons: json['number_of_seasons'].toString(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'].toString(),
        voteCount: json['vote_count'].toString(),
      );
}
