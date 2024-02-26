import 'package:isar/isar.dart';
import 'package:movieplex/domain/datasources/local_storage_datasource.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDataSourceImpl implements LocalStorageDataSource {
  late final Future<Isar> db = _openDb();

  Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          MovieSchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<Movie>> getFavoriteMovies(
      {int limit = 10, int offset = 0}) async {
    final isar = await db;

    final allMovies = await isar.movies.where().findAll();
    return allMovies.skip(offset).take(limit).toList();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final count = await isar.movies.where().filter().idEqualTo(movieId).count();

    return count > 0;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final isFavorite = await isMovieFavorite(movie.id);

    if (isFavorite) {
      isar.writeTxnSync(() => isar.movies.deleteSync(movie.isarId!));
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
