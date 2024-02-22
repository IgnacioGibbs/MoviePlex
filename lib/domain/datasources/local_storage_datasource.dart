import 'package:movieplex/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0});
}
