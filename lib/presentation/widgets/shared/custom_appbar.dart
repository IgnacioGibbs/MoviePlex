import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:movieplex/domain/entities/movie.dart';

import 'package:movieplex/presentation/delegates/search_movie_delegate.dart';

import '../../providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.movie_filter_outlined,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 10.0),
                    Text('Movieplex', style: titleStyle),
                    const Spacer(),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final moviesRepository =
                              ref.read(searchedMoviesProvider);

                          final searchQuery = ref.read(searchMovieProvider);

                          showSearch<Movie?>(
                                  query: searchQuery,
                                  context: context,
                                  delegate: SearchMovieDelegate(
                                      initialMovies: moviesRepository,
                                      searchMovies: ref
                                          .read(searchedMoviesProvider.notifier)
                                          .searchMoviesByQuery))
                              .then((movie) {
                            if (movie != null) {
                              context.push('/movie/${movie.id}');
                            }
                          });
                        }),
                  ],
                ))));
  }
}
