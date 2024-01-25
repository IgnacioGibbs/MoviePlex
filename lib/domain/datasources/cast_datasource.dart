import 'package:movieplex/domain/entities/cast.dart';

abstract class CastsDataSource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
