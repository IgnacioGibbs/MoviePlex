import 'package:dio/dio.dart';
import 'package:movieplex/config/constants/environment.dart';
import 'package:movieplex/domain/datasources/movies_datasource.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/infrastructure/mappers/movie_mapper.dart';
import 'package:movieplex/infrastructure/models/themoviedb/movie_details.dart';
import 'package:movieplex/infrastructure/models/themoviedb/themoviedb_response.dart';

class MovieDataSource extends MoviesDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.getTheMovieDbKey(),
    'language': 'en-US', // TODO: Add language support
  }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final TheMovieDbResponse theMovieDbResponse =
        TheMovieDbResponse.fromJson(json);

    final List<Movie> movies = theMovieDbResponse.results
        .where((themoviedb) => themoviedb.posterPath != 'not_found')
        .map((themoviedb) => MovieMapper.theMovieDbToEntity(themoviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception("Movie with id: $id not found");
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
}
