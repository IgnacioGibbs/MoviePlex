import 'package:isar/isar.dart';
import 'package:movieplex/domain/datasources/local_storage_datasource.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDataSourceImpl implements LocalStorageDataSource {
  late Future<Isar> db;

  IsarDataSourceImpl() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
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
  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0}) {
    // TODO: implement getFavoriteMovies
    throw UnimplementedError();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
