import 'package:movieplex/domain/entities/cast.dart';
import 'package:movieplex/infrastructure/models/themoviedb/credits_response.dart';

class CastMapper {
  static Actor castToEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      character: cast.character,
    );
  }
}
