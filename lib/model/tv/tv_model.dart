class TV {
  final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final int? voteCount;
  final String? voteAverage;

  late String error;

  TV(
      {this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAirDate,
      this.name,
      this.voteCount,
      this.voteAverage});

  factory TV.fromJson(dynamic json) {
    return TV(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toString());
  }
}
