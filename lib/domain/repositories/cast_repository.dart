import 'package:movieplex/domain/entities/cast.dart';

abstract class CastRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
