import 'package:movie_finder/models/actor.dart';
import 'package:movie_finder/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final List<Actor>? casting;
  final String? posterPath;
  final List<String>? genres;
  final double? voteAverage;
  final String? releaseDate;
  final List<String>? videos;

  const Movie({
    required this.id,
    required this.name,
    required this.description,
    this.casting,
    this.posterPath,
    this.genres,
    this.voteAverage,
    this.releaseDate,
    this.videos,
  });

  Movie copyWith(
      {int? id,
      String? name,
      String? description,
      List<Actor>? casting,
      String? posterPath,
      List<String>? genres,
      double? voteAverage,
      String? releaseDate,
      List<String>? videos}) {
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        casting: casting ?? this.casting,
        description: description ?? this.description,
        posterPath: posterPath ?? this.posterPath,
        genres: genres ?? this.genres,
        voteAverage: voteAverage ?? this.voteAverage,
        releaseDate: releaseDate ?? this.releaseDate,
        videos: videos ?? this.videos);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'posterPath': posterPath,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      name: map['title'] as String,
      description: map['overview'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  String posterURL() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

  String reformatGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = '$categories ${genres![i]}, ';
      }
    }

    return categories;
  }
}
