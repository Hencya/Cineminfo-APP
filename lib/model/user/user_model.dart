class Users {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  List? movieFavourite;
  List? tvFavourite;
  List? actorFavourite;

  Users(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.movieFavourite,
      this.tvFavourite,
      this.actorFavourite});

  factory Users.fromMap(map) {
    return Users(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        password: map['password'],
        phone: map['phone'],
        movieFavourite: map['movieFavourite'],
        tvFavourite: map['tvFavourite'],
        actorFavourite: map['actorFavourite']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
      'movieFavourite': movieFavourite,
      'tvFavourite': tvFavourite,
      'actorFavourite': actorFavourite
    };
  }
}
