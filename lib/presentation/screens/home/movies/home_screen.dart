import 'package:flutter/material.dart';

import 'package:movieplex/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoviePlex'),
      ),
      body: Center(
        child: Text(Environment.getTheMovieDbKey()),
      ),
    );
  }
}
