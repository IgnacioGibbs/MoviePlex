import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movieplex/presentation/delegates/search_movie_delegate.dart';
import 'package:movieplex/presentation/providers/movies/movies_repository_provider.dart';

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
                            ref.read(movieRepositoryProvider);

                        showSearch(
                            context: context,
                            delegate: SearchMovieDelegate(
                                searchMovies: moviesRepository.searchMovie));
                      },
                    ),
                  ],
                ))));
  }
}
