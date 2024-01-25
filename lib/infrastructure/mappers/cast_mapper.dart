import 'package:movieplex/domain/entities/cast.dart';
import 'package:movieplex/infrastructure/models/themoviedb/credits_response.dart';

class CastMapper {
  static Actor castToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.freeiconspng.com/uploads/no-image-icon-4.png',
      character: cast.character,
    );
  }
}
