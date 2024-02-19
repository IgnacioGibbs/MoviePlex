import 'package:go_router/go_router.dart';

import 'package:movieplex/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final index = int.parse(state.pathParameters['page'] ?? '0');

          if (index < 0 || index > 2) {
            return const HomeScreen(pageIndex: 0);
          }

          return HomeScreen(pageIndex: index);
        },
        routes: [
          GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MovieScreen(movieId: movieId);
              }),
        ]),
  ],
);
