import 'package:flutter/material.dart';

import 'package:movieplex/presentation/views/views.dart';
import 'package:movieplex/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final List<Widget> _pages = const [
    HomeView(),
    CategoriesView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex));
  }
}
