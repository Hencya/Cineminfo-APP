import 'package:cineminfo/model/images/images_model.dart';
import 'package:equatable/equatable.dart';

class TvImages extends Equatable {
  final List<Images>? backdrops;
  final List<Images>? posters;

  const TvImages({this.backdrops, this.posters});

  factory TvImages.fromJson(Map<String, dynamic> result) {
    return TvImages(
      backdrops:
          (result['backdrops'] as List).map((b) => Images.fromJson(b)).toList(),
      posters:
          (result['posters'] as List).map((b) => Images.fromJson(b)).toList(),
    );
  }

  @override
  List<Object> get props => [backdrops!, posters!];
}
