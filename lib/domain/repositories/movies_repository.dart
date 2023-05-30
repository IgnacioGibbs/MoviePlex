import 'package:movieplex/domain/entities/movie.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getMovies({int page = 1});
}
