import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/model/tv/tv_model.dart';

class CastDetail {
  String? id;
  String? name;
  String? biography;
  String? popularity;
  String? profilePath;
  String? birthday;
  String? placeOfBirth;
  String? knownForDepartment;

  late List<Movie>? movieCredits;
  late List<TV>? tvCredits;

  CastDetail(
      {this.id,
      this.name,
      this.biography,
      this.popularity,
      this.profilePath,
      this.birthday,
      this.placeOfBirth,
      this.knownForDepartment});

  factory CastDetail.fromJson(dynamic json) {
    return CastDetail(
        id: json['id'].toString(),
        biography: json['biography'],
        name: json['name'],
        profilePath: json['profile_path'],
        knownForDepartment: json['known_for_department'],
        birthday: json['birthday'],
        placeOfBirth: json['place_of_birth'],
        popularity: json['popularity'].toString());
  }
}
