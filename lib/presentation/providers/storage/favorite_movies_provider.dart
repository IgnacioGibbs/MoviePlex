import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieplex/domain/entities/movie.dart';
import 'package:movieplex/domain/repositories/local_storage_repository.dart';
import 'package:movieplex/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.getFavoriteMovies(
      limit: 15,
      offset: page * 10,
    );

    page++;

    state = {
      ...state,
      for (final movie in movies) movie.id: movie,
    };

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {
        ...state,
        movie.id: movie,
      };
    }
  }
}
