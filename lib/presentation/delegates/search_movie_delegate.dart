import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movieplex/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.searchMovies});

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
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: searchMovies(query),
        initialData: const [],
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
              itemBuilder: (context, index) {
                final movie = movies[index];

                return ListTile(
                  leading: FadeInLeft(
                      child: Image.network(
                          movie.posterPath ??=
                              'https://www.freeiconspng.com/uploads/no-image-icon-4.png',
                          width: 50.0,
                          fit: BoxFit.cover)),
                  title: FadeInRight(child: Text(movie.title)),
                  onTap: () => close(context, movie),
                );
              });
        });
  }
}
