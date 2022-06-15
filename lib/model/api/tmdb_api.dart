import 'package:cineminfo/model/cast/cast_detail.dart';
import 'package:cineminfo/model/cast/cast_list_model.dart';
import 'package:cineminfo/model/cast/cast_model.dart';
import 'package:cineminfo/model/genre/genre_model.dart';
import 'package:cineminfo/model/movie/movie_detail.dart';
import 'package:cineminfo/model/movie/movie_images.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/model/tv/tv_detail.dart';
import 'package:cineminfo/model/tv/tv_images.dart';
import 'package:cineminfo/model/tv/tv_model.dart';
import 'package:dio/dio.dart';

class TmdbApi {
  static Future<List<Movie>> getNowPlayingMovie() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getPopularMovie() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/movie/popular?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getTopRatedMovie() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/movie/top_rated?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getUpcomingMovie() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/movie/upcoming?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getTvAiring() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/tv/airing_today?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getTvOnTheAir() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/tv/on_the_air?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getTvPopular() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/tv/popular?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getTvTopRated() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      const url = '$baseUrl/tv/top_rated?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getMovieByGenre(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Genre>> getGenreList() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/genre/movie/list?$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Person>> getTrendingWeekPerson() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/trending/person/week?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Person>> getTrendingDayPerson() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/trending/person/day?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Person>> getPopularPerson() async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/person/popular?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<MovieDetail> getMovieDetail(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);

      movieDetail.trailerId = await getMovieYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getMovieCastList(movieId);

      movieDetail.similarMovies = await getSimilarMovie(movieId);

      movieDetail.recomendationMovies = await getRecomendationMovie(movieId);

      return movieDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<TvDetail> getTvDetail(int tvId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/tv/$tvId?$apiKey');
      TvDetail tvDetail = TvDetail.fromJson(response.data);

      tvDetail.trailerId = await getTvYoutubeId(tvId);

      tvDetail.tvImages = await getTvImage(tvId);

      tvDetail.castList = await getTvCastList(tvId);

      tvDetail.similarTv = await getSimilarTv(tvId);

      tvDetail.recomendationTv = await getRecomendationTv(tvId);

      return tvDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<CastDetail> getCastDetail(int castId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/person/$castId?$apiKey');
      CastDetail castDetail = CastDetail.fromJson(response.data);

      castDetail.movieCredits = await getCastMovieCredits(castId);

      castDetail.tvCredits = await getCastTvCredits(castId);

      return castDetail;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getSimilarMovie(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/movie/$movieId/similar?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getSimilarTv(int tvId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/tv/$tvId/similar?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getRecomendationMovie(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/movie/$movieId/recommendations?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getRecomendationTv(int tvId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/tv/$tvId/recommendations?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['results'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> getCastMovieCredits(int castId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/person/$castId/movie_credits?$apiKey';
      final response = await dio.get(url);
      var movies = response.data['cast'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> getCastTvCredits(int castId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final url = '$baseUrl/person/$castId/tv_credits?$apiKey';
      final response = await dio.get(url);
      var tvs = response.data['cast'] as List;
      List<TV> tvList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<String> getMovieYoutubeId(int id) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<String> getTvYoutubeId(int id) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/tv/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<MovieImage> getMovieImage(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      // print('data = ${response.data}');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<TvImages> getTvImage(int tvId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/tv/$tvId/images?$apiKey');
      // print('data = ${response.data}');
      return TvImages.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Cast>> getMovieCastList(int movieId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              id: c['id'],
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Cast>> getTvCastList(int tvId) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get('$baseUrl/tv/$tvId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list
          .map((c) => Cast(
              id: c['id'],
              name: c['name'],
              profilePath: c['profile_path'],
              character: c['character']))
          .toList();
      return castList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Movie>> searchMovie(String query) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get(
          '$baseUrl/search/movie?$apiKey&query=$query&include_adult=false');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<TV>> searchTv(String query) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio
          .get('$baseUrl/search/tv?$apiKey&query=$query&include_adult=false');
      var tvs = response.data['results'] as List;
      List<TV> tvsList = tvs.map((m) => TV.fromJson(m)).toList();
      return tvsList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  static Future<List<Person>> searchPerson(String query) async {
    final Dio dio = Dio();
    const String baseUrl = 'https://api.themoviedb.org/3';
    const String apiKey = 'api_key=df6f3cc06fc84af97a0568c3bb8e44ce';
    try {
      final response = await dio.get(
          '$baseUrl/search/person?$apiKey&query=$query&include_adult=false');
      var persons = response.data['results'] as List;
      List<Person> personsList =
          persons.map((m) => Person.fromJson(m)).toList();
      return personsList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
