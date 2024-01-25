import 'package:movieplex/domain/datasources/cast_datasource.dart';
import 'package:movieplex/domain/entities/cast.dart';
import 'package:movieplex/domain/repositories/cast_repository.dart';

class CastRepositoryImpl extends CastRepository {
  final CastsDataSource dataSource;
  CastRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
}
