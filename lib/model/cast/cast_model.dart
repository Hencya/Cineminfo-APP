class Person {
  final int? id;
  final String? gender;
  final String? name;
  final String? profilePath;
  final String? knowForDepartment;
  final String? popularity;

  Person(
      {this.id,
      this.gender,
      this.name,
      this.profilePath,
      this.knowForDepartment,
      this.popularity});

  factory Person.fromJson(dynamic json) {
    return Person(
        id: json['id'],
        gender: json['gender'].toString(),
        name: json['name'],
        profilePath: json['profile_path'],
        knowForDepartment: json['known_for_department'],
        popularity: json['popularity'].toString());
  }
}
