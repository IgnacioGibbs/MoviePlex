import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/presentation/providers/providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  return nowPlayingMovies.isEmpty ? [] : nowPlayingMovies.take(6).toList();
});
