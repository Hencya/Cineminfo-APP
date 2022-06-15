import 'package:cineminfo/model/cast/cast_list_model.dart';
import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:cineminfo/model/movie/movie_images.dart';
import 'package:cineminfo/model/movie/movie_model.dart';

class MovieDetail {
  final String? id;
  final String? title;
  final String? backdropPath;
  final String? budget;
  final String? homePage;
  final String? originalTitle;
  final String? overview;
  final String? releaseDate;
  final String? runtime;
  final String? voteAverage;
  final String? voteCount;
  final List<Genre>? genres;

  late String trailerId;
  late MovieImage movieImage;
  late List<Movie> similarMovies;
  late List<Movie> recomendationMovies;
  late List<Cast>? castList;

  MovieDetail(
      {this.id,
      this.title,
      this.backdropPath,
      this.budget,
      this.homePage,
      this.originalTitle,
      this.overview,
      this.releaseDate,
      this.runtime,
      this.voteAverage,
      this.voteCount,
      this.genres});

  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
      id: json['id'].toString(),
      title: json['title'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'].toString(),
      homePage: json['home_page'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'].toString(),
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
      genres: (json["genres"] as List).map((i) => Genre.fromJson(i)).toList(),
    );
  }
}
