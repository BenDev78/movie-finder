// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movie_finder/services/api.dart';

class Actor {
  final String name;
  final String character;
  final String? profilePath;
  Actor({
    required this.name,
    required this.character,
    this.profilePath,
  });

  Actor copyWith({
    String? name,
    String? character,
    String? profilePath,
  }) {
    return Actor(
      name: name ?? this.name,
      character: character ?? this.character,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'character': character,
      'profilePath': profilePath,
    };
  }

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      name: map['name'] as String,
      character: map['character'] as String,
      profilePath:
          map['profile_path'] != null ? map['profile_path'] as String : null,
    );
  }

  factory Actor.fromJson(String source) =>
      Actor.fromMap(json.decode(source) as Map<String, dynamic>);

  String profileUrl() {
    API api = API();

    return api.baseImageURL + profilePath!;
  }
}
