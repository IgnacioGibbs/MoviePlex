import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/infrastructure/datasources/themoviedb_datasource_impl.dart';
import 'package:movieplex/infrastructure/repositories/movie_repository_impl.dart';

// This repository is inmutable, so we can use a provider. So is only-lecture
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(TheMovieDbDataSource());
});
