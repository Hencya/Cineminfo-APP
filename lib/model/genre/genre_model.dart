import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;

  late String error;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(dynamic json) {
    return Genre(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [id, name];
}
