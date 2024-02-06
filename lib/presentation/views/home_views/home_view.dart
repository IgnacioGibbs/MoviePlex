import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movieplex/presentation/providers/providers.dart';
import 'package:movieplex/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(firstLoadProvider);
    if (initialLoading) return const FullScreenLoader();

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        title: CustomAppBar(),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: moviesSlideshow),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Now Playing',
              subtitle: 'On billboard',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Popular',
              subtitle: 'More views',
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Upcoming',
              subtitle: 'Expected releases',
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
                height:
                    10) //Para dar espacio en el fondo y se vea el rebote de la app
          ],
        );
      }, childCount: 1))
    ]);
  }
}
