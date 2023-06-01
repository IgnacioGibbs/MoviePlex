import 'package:dio/dio.dart';
import 'package:movieplex/config/constants/environment.dart';
import 'package:movieplex/domain/datasources/movies_datasource.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/infrastructure/mappers/movie_mapper.dart';
import 'package:movieplex/infrastructure/models/themoviedb/themoviedb_response.dart';

class TheMovieDbDataSource extends MoviesDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.getTheMovieDbKey(),
    'language': 'en-US', // TODO: Add language support
  }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    final TheMovieDbResponse theMovieDbResponse =
        TheMovieDbResponse.fromJson(response.data);

    final List<Movie> movies = theMovieDbResponse.results
        .where((themoviedb) => themoviedb.posterPath != 'not_found')
        .map((themoviedb) => MovieMapper.theMovieDbToEntity(themoviedb))
        .toList();

    return movies;
  }
}
