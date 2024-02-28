import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieplex/presentation/providers/providers.dart';
import 'package:movieplex/presentation/widgets/widgets.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    if (movies.isEmpty) {
      isLastPage = true;
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_rounded,
              size: 60,
              color: colors.primary,
            ),
            const SizedBox(height: 20),
            Text('No favorite movies yet!',
                style: TextStyle(color: colors.primary, fontSize: 20)),
            const Text('Add movies to your favorites to see them here!',
                style: TextStyle(color: Colors.black45, fontSize: 14)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => context.go('/home/0'),
                child: const Text('Discover Movies')),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: favoriteMovies),
    );
  }
}
