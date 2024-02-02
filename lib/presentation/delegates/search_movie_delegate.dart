import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movieplex/config/helpers/human_formats.dart';
import 'package:movieplex/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  StreamController debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  void _onQueryChange(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debounceMovies.add(movies);
    });
  }

  void clearStream() {
    debounceMovies.close();
  }

  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () => query = '',
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => {
              clearStream(),
              close(context, null),
            });
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);

    return StreamBuilder(
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data ?? [];

          if (movies.isEmpty) {
            return const Center(child: Text('No results found'));
          }

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context, movie) {
                    clearStream();
                    close(context, movie);
                  }));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child)),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 100 && movie.overview.isNotEmpty)
                      ? Text('${movie.overview.substring(0, 100)}...',
                          style: textStyle.titleSmall)
                      : Text(movie.overview, style: textStyle.titleSmall),
                  Row(
                    children: [
                      const Icon(Icons.star_half_rounded, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                          HumanFormats.number(movie.voteAverage,
                              decimalDigits: 1),
                          style: textStyle.bodySmall!.copyWith(
                              color: Colors.amber.shade600,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
