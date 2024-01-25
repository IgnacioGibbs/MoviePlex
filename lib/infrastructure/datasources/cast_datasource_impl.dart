import 'package:dio/dio.dart';
import 'package:movieplex/config/constants/environment.dart';
import 'package:movieplex/domain/datasources/cast_datasource.dart';
import 'package:movieplex/domain/entities/cast.dart';
import 'package:movieplex/infrastructure/mappers/cast_mapper.dart';
import 'package:movieplex/infrastructure/models/themoviedb/credits_response.dart';

class CastDataSource extends CastsDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.getTheMovieDbKey(),
    'language': 'en-US', // TODO: Add language support
  }));

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final CreditsResponse castResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors =
        castResponse.cast.map((cast) => CastMapper.castToEntity(cast)).toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    return _jsonToActor(response.data);
  }
}
