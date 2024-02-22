import 'package:movieplex/domain/datasources/local_storage_datasource.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0}) {
    return dataSource.getFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }
}
